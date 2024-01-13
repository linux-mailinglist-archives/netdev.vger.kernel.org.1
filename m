Return-Path: <netdev+bounces-63447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E39282CF59
	for <lists+netdev@lfdr.de>; Sun, 14 Jan 2024 00:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D492831A8
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 23:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7F15AF9;
	Sat, 13 Jan 2024 23:10:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cx11.kasperd.dk (cx11.kasperd.dk [116.203.140.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D725168A7
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sgcrd.13.jan.2024.kasperd.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgcrd.13.jan.2024.kasperd.net
Received: from [127.0.0.1] (helo=sgcrd.13.jan.2024.kasperd.net)
	by cx11.kasperd.dk with smtp (Exim 4.90_1)
	(envelope-from <kasperd@sgcrd.13.jan.2024.kasperd.net>)
	id 1rOmbH-0001TF-NY; Sat, 13 Jan 2024 23:35:35 +0100
Date: Sat, 13 Jan 2024 23:35:33 +0100
From: Kasper Dupont <kasperd@sgcrd.13.jan.2024.kasperd.net>
To: netdev@vger.kernel.org
Subject: Receiving GENEVE packets for one VNI in user mode
Message-ID: <20240113223533.GA3929032@sniper.kasperd.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-7
Content-Disposition: inline
Accept-Language: en-GB, da-DK, en-US

Is there a way for a user mode program to receive GENEVE packets
targeted at one specified VNI? None of the GENEVE related webpages I
have been reading through have brought me closer to an answer.

I can think of three different approaches, but each come with its
own problems making it not look like a viable solution.


Approach 1:

The most straightforward approach I can think of is to open a UDP
socket attach BPF rules to filter on VNI and bind it to port 6081.
This should work as long as there is nothing else on the host using
GENEVE.

But I don't see any way to get this approach working if multiple
programs are to receive GENEVE packets for different VNI and
simultaneously use the kernel drivers to receive packets for other
VNI.

Approach 2:

Use a raw socket to receive all UDP packets. Because there is a
possibility that packets arrive fragmented it has to duplicate the
reasembly work in user mode. And because the VNI will only be present
in one fragment, filtering has to be done after reassembly. So I
couldn't rely on BPF.

This approach seems possible but very inefficient.

Approach 3:

Use ip-link(8) to create a tunnel device and bind a raw socket to that
virtual interface. This will however only receive the encapsulated
packets and not the GENEVE header, so it would be unsuitable for any
use case that needs the actual GENEVE header. It would also lose all
packets with critical options that aren't understood by the kernel but
may be understood by the user mode program.


Is there a way to make one of these approaches work or some other way
to achieve it?

If it is impossible to do in user mode do you think a kernel module to
add the functionality would be possible with the current kernel code?

