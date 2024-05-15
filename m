Return-Path: <netdev+bounces-96651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC7C8C6DF6
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 23:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5C9283E3C
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 21:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F35115B540;
	Wed, 15 May 2024 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwZRIjY7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E0155A57
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809729; cv=none; b=VfDKUTEiSev6Bk4ZDToTtvTou6SDxgkHAR0dtyIK1afm8uynjgNPxJQ5Wp4xvh0hWeVCj3yBKJCGwZHb8DNhnFq44EpBIvvqQ3mrnuAxo77TyfkQNPhR3ZERLnvBhf6YGXhDqY8bNHW4QFZWA4/eC7qjF2R5mppEluSlJD5yNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809729; c=relaxed/simple;
	bh=OacZWiiA2yUFJRxQ+ymMV8baNsQxtbQKez1vb+c3hso=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BQK4Mad+xcYbS4yzs8fJuYsVQkJnxt1iVyI9zIEZIASanp+wlzvtmgFCoA/dmmik36xMHyrzJOf164R8y2WcIzQ526FBLiQ/ZwMYGUyJZbZzxg1u4GrmMCCCjewpCEkk9lhBjSeJ6zMcSuQQA2y426Q/JRGR1MtI5GwoYBAh9O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwZRIjY7; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b5de48126so33797366d6.3
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715809725; x=1716414525; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OacZWiiA2yUFJRxQ+ymMV8baNsQxtbQKez1vb+c3hso=;
        b=dwZRIjY7PcGOEpHr7IdPgpZAFW5C4JTsCyfZl1QapIgVss4w4KB9Q5k2UK0X8YdmES
         WWzDCcWmJcT02x8EMRHNeIgeqfkz5Oa1lFd9HnvJuP7LAMJSeHAPkUxrZ4Zh+YoOcqCG
         22UindWPAq1MvmdIA99MWwHeRJhNq4mLicU/OxMBNwgw+8q9y+Af8A4vLD+TLZIkqsQb
         riFdOd4mc+1+mx8yUBhrTy708LmvpOvgd7KeJ5tP5JddppGgQGqL/DfWMK1fjeapibwe
         PyGkxqqEHO03y9Wms2g4DIv5wbjmlfRuzYATJ+NPFfqU9f2Io3/NyZR16c1Qsc3Wwoij
         a8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715809725; x=1716414525;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OacZWiiA2yUFJRxQ+ymMV8baNsQxtbQKez1vb+c3hso=;
        b=sk9F/gQjYRZghPnsfeSILiPDLkHXOggbURy3keLkXjWJiS81FPlAd4SqxkAJZdzMml
         n6Hni+gd14Exoo9+gOOKbVaDeszrfp1eyd4oooM6xuIORNaDhE8Ha7cnwzZN6BcivaLa
         yXuE2bCQG2u6+aIDp4dEFS814ZaY9kMplQjnt2R0VQEL5kytWv/7lNq6Dg4ma+T/VRpc
         6AVnOQCP3PlmdczFSP/3rMyNvtn0gRocxMaa9jddpfJU78jhEbmMrDy0cRIi1be4PdXg
         LtmHm0whJx6+Lfv+Iryl1ODlOc3fkV2uIoD1h+CbJoYYzdF1CWTQOkL616jWghhCxXF8
         ZXdw==
X-Gm-Message-State: AOJu0YxizSmNU4orkDz7TZoCyS6/nJYqsRGQFDQRN06C1uMmGQ0i7pv2
	Su4IBZhti9dGGousL7yi8xE1d+3CiN1jL+FQESDtza4X7xD75OxjN9v3uoJ4O3i7r9KwjgnSsoI
	cNmhbiwGyKo7KSjKYtr79ocf8Q+gFaBpL
X-Google-Smtp-Source: AGHT+IG3qGf2P138z6XgMxIHoOeXuAdt0VCeg+YT6/1mpQDQ6reqTS0idGhtsy0/+VfnmGd6/vpVTaXa2p4LzQUzPY8=
X-Received: by 2002:a05:6214:2f11:b0:6a0:c933:4d7d with SMTP id
 6a1803df08f44-6a1682080ffmr203837896d6.48.1715809725548; Wed, 15 May 2024
 14:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Emil.s" <emil.sandnabba@gmail.com>
Date: Wed, 15 May 2024 23:48:34 +0200
Message-ID: <CAEA9r7AR9DwbophLeJ4ScggYako=YfBtRYgd5TfCfNfovw24HA@mail.gmail.com>
Subject: Martian source when routing packets through ipvlan device with loose
 rp_filter on parent interface
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

I've found what I think might be a bug in the reverse path filtering,
when used in combination with ipvlan devices.

As a simple example I've setup an environment with one client and one gateway:

Gateway:
* ens4f0: 10.1.1.1/16 (Physical interface)
* usb0 (Physical interface - 8c:ae:4c:fe:00:a7)
* ipvlan_usb@usb0: 192.168.0.1/24 (ipvlan mode l2/bridge)

Gateway routing table:
gateway #> ip ro
10.1.0.0/16 dev ens4f0 proto kernel scope link src 10.1.1.1
192.168.0.0/24 dev ipvlan_usb proto kernel scope link src 192.168.0.1

Client:
* eth0 (58:ef:68:b5:0d:46): 192.168.0.1/24
* `ip route add 10.1.0.0/16 via 192.168.0.1`

Client routing table:
client #> ip ro
10.1.0.0/16 via 192.168.0.1 dev eth0
192.168.0.0/24 dev eth0 proto kernel scope link src 192.168.0.2

From the client, I can ping the gateway without any issues
(192.168.0.1). But when I try to ping 10.1.1.1, the packets are just
dropped with the following log lines shown on the gateway:
kernel: IPv4: martian source 10.1.1.1 from 192.168.0.2, on dev usb0
kernel: ll header: 00000000: 8c ae 4c fe 00 a7 58 ef 68 b5 0d 46 08 00

I would expect this behavior using strict reverse path filtering,
since the packet will enter the usb0 interface, but the IP and route
belong to a sub-interface.
But in my case, I'm using "2 - loose mode" that states: "Each incoming
packet's source address is also tested against the FIB and if the
source address is not reachable via any interface the packet check
will fail."
As seen in the routing table, I do have a route to both subnets, so I
should get a match in my FIB.

Disabling rp_filter (0) on the 'usb0' interface solves the issue, and
packets will get routed normally. Another workaround is to delete the
kernel route from the ipvlan device and manually adding it to the
physical device:
gateway #> ip ro del 192.168.0.0/24 dev ipvlan_usb
gateway #> ip ro add 192.168.0.0/24 dev usb0

I've tested this on both Linux 5.15 on Ubuntu 22.04, as well as Linux
6.8.9 on Arch linux with the same result.
I hope I got this right, It's my first time mailing the kernel mailing lists.

Best regards

Emil Sandnabba

