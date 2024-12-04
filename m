Return-Path: <netdev+bounces-148947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60B9E3937
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395BF1687EE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A611B6D03;
	Wed,  4 Dec 2024 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="KbnJnTXw"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E01B5823
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312923; cv=none; b=OwwcmITD/u76v36bPAdPgQ+o/p54k5cpVw3LF+o94wijrxTtyIp6r3HeBz4G2Uiqnj2eVu7monxKN88L5s6Y7DSeGCglXCJZmcGSx6aC+Z9FB90bUS7RnyA6aLngPqXeGKpPqEbZ+7SN6fm0qgHTJEa24DacXOI6WiCvum8i3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312923; c=relaxed/simple;
	bh=nyVNdfAXbECWDE8fRAC1zWunXVRaGbxh8QxhpKaidv0=;
	h=Message-ID:Date:MIME-Version:To:References:From:Cc:Subject:
	 In-Reply-To:Content-Type; b=JFUZD5FcOMvfU9jWvjFefwKoxnv95NLQAhVxTQN2ivIFe+XNQG81MupoLWKYAdfI6l+aQ1yYOoziq6tOs+hArMv0qkhre4IiznM3pID/ZTDUmnuy3nj7t8FW9mBDx77kjYDz0JHoylunyWRhIxVmxnjavJEyATupkF8z4gL4UTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=KbnJnTXw; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:9c63:293c:9db9:bde3] (unknown [IPv6:2a02:8010:6359:2:9c63:293c:9db9:bde3])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id E95DB7DCB3;
	Wed,  4 Dec 2024 11:48:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1733312914; bh=nyVNdfAXbECWDE8fRAC1zWunXVRaGbxh8QxhpKaidv0=;
	h=Message-ID:Date:MIME-Version:To:References:From:Cc:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<3e6af55f-3270-604b-c134-456200188f94@katalix.com>|
	 Date:=20Wed,=204=20Dec=202024=2011:48:33=20+0000|MIME-Version:=201
	 .0|To:=20Preston=20<preston@yourpreston.com>|References:=20<CABBfi
	 em067qtdVbMeq2bGrn-5bKZsy_M8N-4GkE0BO6Uh7jX1A@mail.gmail.com>|From
	 :=20James=20Chapman=20<jchapman@katalix.com>|Cc:=20netdev=20<netde
	 v@vger.kernel.org>|Subject:=20Re:=20ethernet=20over=20l2tp=20with=
	 20vlan|In-Reply-To:=20<CABBfiem067qtdVbMeq2bGrn-5bKZsy_M8N-4GkE0BO
	 6Uh7jX1A@mail.gmail.com>;
	b=KbnJnTXwF979Fcmw8VTMYlyys1h8i5WYyWHP1XFtepFfcBXVAdtdSqQwGYnPOx+3m
	 07DZA9wHKSL+2O5JG2mO6LIMJ/IIO58+T2l+fR3MG1OBZKSsG6W0RzPgRziHPbabEw
	 jwhFbfzFzjD3Z+7C3H5lKFIzq0xKxn8d4rRf1zHoIQJoykISv3nIK3u1Dsn8ITqvGR
	 4413q1wJCL0MJCAN/awnWt4s5KtIBPzgpyi6QOR7n7P6aD/LNJYRrWafpUmtGIoEGP
	 wJoNvYi8fQ8rTQfWdanAWLNVIOpXerLO20kqm0eZL3AWEt8xCceNnFVoYlU6KaQurW
	 dz8sFcB9/2qMA==
Message-ID: <3e6af55f-3270-604b-c134-456200188f94@katalix.com>
Date: Wed, 4 Dec 2024 11:48:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Preston <preston@yourpreston.com>
References: <CABBfiem067qtdVbMeq2bGrn-5bKZsy_M8N-4GkE0BO6Uh7jX1A@mail.gmail.com>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Cc: netdev <netdev@vger.kernel.org>
Subject: Re: ethernet over l2tp with vlan
In-Reply-To: <CABBfiem067qtdVbMeq2bGrn-5bKZsy_M8N-4GkE0BO6Uh7jX1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/12/2024 16:14, Preston wrote:
> Hello folks, please let me know if there’s a more appropriate place to
> ask this but I believe I’ve found something that isn’t supported in
> iproute2 and would like to ask your thoughts.

Thanks for reaching out.

> I am trying to encapsulate vlan tagged ethernet traffic inside of an
> l2tp tunnel.This is something that is actively used in controllerless
> wifi aggregation in large networks alongside Ethernet over GRE. There
> are draft RFCs that cover it as well. The iproute2 documentation I’ve
> found on this makes it seem that it should work but isn’t explicit.
> 
> Using a freshly compiled iproute2 (on Rocky 8) I am able to make this
> work with GRE without issue. L2tp on the other hand seems to quietly
> drop the vlan header. I’ve tried doing the same with a bridge type
> setup and still see the same behavior. I've been unsuccessful in
> debugging it further, I don’t think the debug flags in iproute2's
> ipl2tp.c are functional and I suppose the issue might instead be in
> the kernel module which isn’t something I’ve tried debugging before.
> Is this a bug? Since plain ethernet over l2tp works I assumed vlan
> support as well.
> 
> 
> # Not Working L2TP:
> [root@iperf1 ~]# ip l2tp add tunnel tunnel_id 1 peer_tunnel_id 1 encap
> udp local 2.2.2.2 remote 1.1.1.1 udp_sport 1701 udp_dport 1701
> [root@iperf1 ~]# ip l2tp add session tunnel_id 1 session_id 1 peer_session_id 1
> [root@iperf1 ~]# ip link add link l2tpeth0 name l2tpeth0.1319 type vlan id 1319
> [root@iperf1 ~]# ip link set l2tpeth0 up
> [root@iperf1 ~]# ip link set l2tpeth0.1319 up
> Results: (captured at physical interface, change wireshark decoding
> l2tp value 0 if checking yourself)
> VLAN header dropped
> Wireshark screenshot: https://i.ibb.co/stMsRG0/l2tpwireshark.png

This should work.

In your test network, how is the virtual interface l2tpeth0 connected to 
the physical interface which you are using to capture packets?

> 
> 
> # Working GRE:
> [root@iperf1 ~]# ip link add name gre1 type gretap remote 1.1.1.1
> [root@iperf1 ~]# ip link add name gre1.120 link gre1 type vlan proto
> 802.1q id 120
> [root@iperf1 ~]# ip link set gre1 up
> [root@iperf1 ~]# ip link set gre1.120 up
> Results:
> VLAN header present
> Wireshark screenshot: https://i.ibb.co/6rJWjg9/grewireshark.png
> 
> 
> -------------------------------------------------------
> ~Preston Taylor
> 


