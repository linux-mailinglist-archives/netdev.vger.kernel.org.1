Return-Path: <netdev+bounces-115681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264A9477F8
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0921F221A9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EB514F136;
	Mon,  5 Aug 2024 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebelschwaden.de header.i=@nebelschwaden.de header.b="z0jfCApy"
X-Original-To: netdev@vger.kernel.org
Received: from mail.worldserver.net (mail.worldserver.net [217.13.200.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC114F12C
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.13.200.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848818; cv=none; b=IkWwct9SgoUQodg81i51Jq5a6JVmuKw9AgVy7dl+FvjyWU/sRE1wHKRJ+mC5LNZaUfgp1XDgclyvJc9xcXSTeT4bwmRz2IFCfeygusFYylPCBLv3+hEYOSIPY04HrVr8ss4lNcfQzQlJ1WDEeUj1upIitw45Y3ReBJ+2a5xpZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848818; c=relaxed/simple;
	bh=U7WPbtoFiC50dutBpqEgkKew3uQitTdNX/FrNo3ZnE8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=YxTa5mC7EDY1MDIOrTlrgFWuTY4ER1mp4zX/R1y6PyrTVADhYh74l/O0TRmBnyK8ZOy7wbonraf3wkE5F0VqaJ0rBW3NytA1HjOhRD9bCMPdZL0pSuQ2ULGQEP4IIwKf1xf7vwE18+AAyoGjL85XPFe7YXLKTqBEqh8gBoaNSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebelschwaden.de; spf=pass smtp.mailfrom=nebelschwaden.de; dkim=pass (2048-bit key) header.d=nebelschwaden.de header.i=@nebelschwaden.de header.b=z0jfCApy; arc=none smtp.client-ip=217.13.200.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebelschwaden.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebelschwaden.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nebelschwaden.de;
	s=1687803001; t=1722848792;
	bh=U7WPbtoFiC50dutBpqEgkKew3uQitTdNX/FrNo3ZnE8=;
	h=Date:From:To:Subject:From;
	b=z0jfCApy/x+E1xmsQ11OBLfNHdRymE9K15n68ObUjXaZuMBSzKVuic/jYFH4fohN4
	 hnP17MpbOh8hXeGnBW3vb7HIaU+WG1w1REsfwg2+iw91PBnjYqFiDig1EByaDi69ke
	 3FbLQQEdWJBovT0UclkUFQ1AQ5bBAbH5NuMHTZJaNHqTouLA3F+BSieyL/dxn9AhrJ
	 RjMyoL1EPEoQN+wvqkNRO0hD0yofVWoarA2Fh8tPhAufzRBIyFAOx30H/tzRFB1Ksq
	 zsdMPMoqFfSyTWE3u0UBb5JKmxx3V87uCXU79OYa4yLhaRBFklQNry1YEO+mDTB1Je
	 708h+xZ6gNicg==
Received: from postpony.nebelschwaden.de (v22018114346177759.hotsrv.de [194.55.14.20])
	(Authenticated sender: sendmail@nebelschwaden.de)
	by mail.worldserver.net (Postfix) with ESMTPSA id 4032C1E0217
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 11:06:31 +0200 (CEST)
Received: from kaperfahrt.nebelschwaden.de (kaperfahrt.nebelschwaden.de [172.16.37.5])
	by postpony.nebelschwaden.de (Postfix) with ESMTP id D8960127C3A
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 11:06:29 +0200 (CEST)
Date: Mon, 5 Aug 2024 11:06:29 +0200
From: Ede Wolf <listac@nebelschwaden.de>
To: netdev@vger.kernel.org
Subject: ipvlan: different behaviour/path of ip4 and ip6?
Message-ID: <20240805110629.3259ddad@kaperfahrt.nebelschwaden.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

Hoping, that this is the poper list to bring forth the issue, as I
experience pakets taking a different path depending on the protocol, in
what I consider otherwise to be an identical configuration for both
protocols.  

I've set up ipvlan l3s on a dual homed host, where the ipvlan hosting
interface is not the interface of the link/subnet in question. 
Basically, the ipvlan is bound to eth1, and the link we are interested
in is eth0. Attached to the ipvlan are two container. The local ipvlan
interface is named exactly so. 

With ipv6 I have got this to work, that is, any host connected to the
subnet on eth0 can ping the container, and vice versa, but with ipv4
it doesn't. 

Here is an excerpt of an ipv4 ping from inside a container (10.10.10.1)
to a machine connected to the link on eth0 (192.168.17.1):

07:29:04.978583 eth1  Out IP (tos 0x0, ttl 64, id 41071, offset 0,
flags [DF], proto ICMP (1), length 84) 10.10.10.1 > 192.168.17.1: ICMP
echo request, id 32850, seq 3, length 64

It obviously takes eth1 as egress, as to be expected, and it is just
that one stage, repeating again and again. 

And here is the same ping using ipv6. With :1010::1 being the container
ip and :1a17::1 being the remote host: 

07:31:29.298589 eth0  Out IP6 (flowlabel 0x50657, hlim 64, next-header
ICMPv6 (58) payload length: 64)  > fde7:dead:beef:1a17::1: [icmp6 sum
ok] ICMP6, echo request, id 30366, seq 6

07:31:29.298856 eth0  In  IP6 (flowlabel 0xd783d, hlim 64, next-header
ICMPv6 (58) payload length: 64)  > fde7:dead:beef:1010::1: [icmp6 sum
ok] ICMP6, echo reply, id 30366, seq 6

07:31:29.298866 ipvlan Out IP6 (flowlabel 0xd783d, hlim 63, next-header
ICMPv6 (58) payload length: 64) fde7:dead:beef:1a17::1 >
fde7:dead:beef:1010::1: [icmp6 sum ok] ICMP6, echo reply, id 30366, seq
6

In this case, the eth0 is used as the egress interface directly, what
makes stuff work. 
For both, I would have expected to see eth1 as egress with
paket then being forwarded to eth0. But that may be my lack of
understanding. 

ip forwarding is globally enabled, no paketfilter in place.  And there
is no real difference in pinging the local eth0 interface from within a
container or an outside host on that link. 
The container has its default gateway set to its device for both
protocols. 

Other way round it is the same, request pakets from an outside host
find their way into the container, but the reply gets stuck @eth1 with
ipv4, while ipv6 works.

Sidenote: the local ipvlan interface is reachable from everywhere, only
the container are not accessible with ipv4. 

I have posted this question with a slightly differnt focus and without
success to the arch forum, where I have also given a simple ascii
diagramm of the setup. 

I just do not know, wether it is appropiate to post the url here.
Putting the diagramm in this mail make no sense due to line break

In case that could be helpful and not considered spam, I of course will
hapily do so

Thanks

Ede

