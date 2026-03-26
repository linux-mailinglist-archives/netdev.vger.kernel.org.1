Return-Path: <netdev+bounces-272168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFB/MHBuxWl1+AQAu9opvQ
	(envelope-from <netdev+bounces-272168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:35:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 110DC339369
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FBEE306A334
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231334219F1;
	Thu, 26 Mar 2026 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="amKeoRSz";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="wULQHrO8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4D421EF7;
	Thu, 26 Mar 2026 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546236; cv=none; b=jf+8gy9c7UeMLj3Q8SYS7VO4sW3TuKHk8D2rGraob0LKb0Me/XhK6AlD5HZRFCnGumuxE9CR8A/trDSLYsUkMVm75Ie1CtpD0l4wCNqC5phMt9FucaFLHw16CtiC7lI2rt9iImQeTrd2urW1aMUC3E0ILsbQ3WTwddmJWbTldt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546236; c=relaxed/simple;
	bh=GDIgImmAITT14mH1h9x1AVZllXLG0K+mrW/IwOibwus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YddUdhg3gticKIncDURK1yMDwwpTUQIaYWR7vactfjHsnK6a9vxY8zGzcb9PBvJW3Thy1TmXv4RiG8x6oHGqRE9hKZGIqxDTu8FtMlg3A10rA+NmJmCrvm3Pf21+2vyggaULTbPhk4qAyl4RHVYQO83JHVbndCFiFh/QURmsUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=amKeoRSz; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=wULQHrO8; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62QHTlq2011685;
	Thu, 26 Mar 2026 18:29:52 +0100
Received: from [10.62.247.239] (93-33-118-253.ip44.fastwebnet.it [93.33.118.253])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 1DEC9122940;
	Thu, 26 Mar 2026 18:29:42 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1774546183; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9I5dW3djYPBEN9GH1zFJpeHiokQiFFD8Dnrwz788XaE=;
	b=amKeoRSzbtxoascx95Vtfoh72dbPlW1kktNlgBrzQc5y5TxxXlYC/VCbOSofWPAwnDPTEP
	HBE+7e+nVAytABBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1774546183; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9I5dW3djYPBEN9GH1zFJpeHiokQiFFD8Dnrwz788XaE=;
	b=wULQHrO85NRYx2qPhcEygGTPL8OSwCZKgGErTOBrjhyooojDJfkMwnp0qXk9j5jnqtCNTP
	Zw0myrTV26uf3vuwAL//h+BL5uEsvwlg4fdrsksAtIjSCaSjOPNGCZT9FZYZ/1K7wSFr1v
	t9/B0+UGpmCcQ4RykMgiVRKqdciKPE3JGbOqkAR4gp7OnnOU5E06HDzRkwN6XJx1JpPAwr
	CWgH8zXt4e4D/haYP9lDPS7ee+rTKDQPxw9C4sPDPqlfTB0Zu3JmpwcRoVXedqtafx7/ys
	lnQaVvYjZotugkpzcC5hKMvxJx9UofUhjy8MOYH3jm2NBlsuHAZxPS9nqS8eSQ==
Message-ID: <55aec00e-3031-44dd-a58d-7a6251891027@uniroma2.it>
Date: Thu, 26 Mar 2026 18:29:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 2/3] seg6: add SRv6 L2 tunnel device (srl2)
Content-Language: it-IT
To: Justin Iurman <justin.iurman@6wind.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>, linux-kernel@vger.kernel.org
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
 <20260322000557.12559-3-andrea.mayer@uniroma2.it>
 <CAOY2Bqxb1C6myf7DBmfLM_3wZSweYQaQSAVSj_wDihf-N9vQJg@mail.gmail.com>
From: Stefano Salsano <stefano.salsano@uniroma2.it>
In-Reply-To: <CAOY2Bqxb1C6myf7DBmfLM_3wZSweYQaQSAVSj_wDihf-N9vQJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272168-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefano.salsano@uniroma2.it,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 110DC339369
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il 25/03/2026 14:43, Justin Iurman ha scritto:
> On Sun, Mar 22, 2026 at 12:06 AM Andrea Mayer <andrea.mayer@uniroma2.it> wrote:
>>
>> Introduce srl2, an Ethernet pseudowire device over SRv6. It
>> encapsulates L2 frames in IPv6 with a Segment Routing Header for
>> transmission across an SRv6 network.
>>
>> The encapsulation logic reuses seg6_do_srh_encap() with
>> IPPROTO_ETHERNET. The transmit path uses the standard IPv6 tunnel
>> infrastructure (dst_cache, ip6_route_output, ip6tunnel_xmit).
>>
>> The device is configured with a segment list for point-to-point
>> L2 encapsulation.
>>
>> Usage:
>>
>>    ip link add srl2-0 type srl2 segs fc00::a,fc00::b
> 
> Thinking out loud...
> 
> We'll likely need SRv6 encap configurations specific to each entry
> (i.e., MAC address), rather than (or in addition to) per interface.

agreed, this is the natural next step towards multipoint
we've started exploring the design for this, happy to collaborate if 
you're interested

> We could also add a "mode" (e.g., "normal" mode or reduced mode?).

good point, the infrastructure is already in place, so adding a "mode" 
parameter to sr6 to support reduced encap should be straightforward

we suggest to address it as an immediate follow-up to this baseline 
series and we have already some prototype code ready

ciao
Stefano and Andrea
-- 
*******************************************************************
Prof. Stefano Salsano
Dipartimento Ingegneria Elettronica
Universita' di Roma Tor Vergata
Viale Politecnico, 1 - 00133 Roma - ITALY

http://netgroup.uniroma2.it/Stefano_Salsano/

E-mail  : stefano.salsano@uniroma2.it
Office  : (Tel.) +39 06 72597770 (Fax.) +39 06 72597435
*******************************************************************


