Return-Path: <netdev+bounces-285360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPdUCO6k/GmRSQAAu9opvQ
	(envelope-from <netdev+bounces-285360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:42:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 157204EA67E
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B5E6303ABFF
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD66140756F;
	Thu,  7 May 2026 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkLKNTMy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6293FB7CE
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164679; cv=none; b=BhFChrVsU7bRR56NgFIVIzN1e7AQbFF0LGyq1pGIDuOY5HQ6SoEKCSLn4UZ/+6C7THA257ZBK2u/9KG5UxLdRqV6e83R4rJL7kbp+3RrfNaEXZYG/kBlE0RR00q/MGSRYjducGw0AqNMtzkYyPf9KFoMRE0OaRo6MPxGFfY49DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164679; c=relaxed/simple;
	bh=+6l+nOdGVkavFeHR/ZWA+j/A/CHvSr6qp4DtjVMSKbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqvhABVM8YFSDhZ/1i0k9yDPxYrjMmmZJ/lYWq5juTLzRwr0g39P8FJZOYmB49WgW5fKDbKx91eBTichPmW48Peadi5tzSv8XDBT8gZNiqrnlb3ZVVP0lnGTtSeN9wOTUlxBtmABnNF0NU1cV8TgLUdQfpsPkYFNTZYTA7MH2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkLKNTMy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so14026645e9.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778164677; x=1778769477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz71/EcJzZj1K6D19jKVwvEn4Qe+HOLKzTAqW7JWDdI=;
        b=ZkLKNTMyYhYmWCkdcW+89LbFWBT2bExH4/uPcHx83LQzyvkfKrBQYCQxt7epv+1cX3
         HfzCHVOq+FDISVnaLglcWycEmhJ/iNhu0bu/qGuhz5l5X+n4UZ3vRKNcLoTOiIgWintW
         26HcRGiyVn6HyTQtP8XOP/RzY7Lt9Ieb639D7dwDOn7Z6hjI2A1YkceJhRuzO3egfE9s
         pVZXOnGHKtJNdgkapBkn8jnI8/n2MNq0+N7FcCbdWGWn+iwTIkHD1y5TNktizrm79War
         BVovg6Z+Eju9k586iFcbZGXIgj2Qb6AFTqaUzFUoAmFEAEIYNgj51ujZzicN96KO+r0w
         PPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778164677; x=1778769477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kz71/EcJzZj1K6D19jKVwvEn4Qe+HOLKzTAqW7JWDdI=;
        b=nIICJ3P7L933hMEbP8Neqj7+M+Jnc0X/APmu/3qihUcRFrbHbrxtes1iVJcSiNtoHb
         3GYdp1jUqmPljeMUTNjocZ3Rtr4p6Z/6JAGRcgut5sWY93Edc99NWJgc20WuFMG9kBJK
         3y3DFY6w44VMO2YpcBgFERXcH6G3W6R88SV2YcM5fVVOh6/5/YNoc6rmst2Ybljwpau8
         yyklYhKNwYjarfrzt58cnf+ut6TjRYZ5I+Lfp5VHh3roy/MAch3EQRIyu/za1WiTgt9d
         iF9uownfJDRuFQy8IHNF7HWlDxWB4+WMcZLmuOU1bFmQLAmsuMh95ojUJPfjRV2McreB
         bl9A==
X-Forwarded-Encrypted: i=1; AFNElJ8oPTElWPT53Z7PZBq9AxJuBtqbMwYRAM0xY55Wa9iKQ+rvmxeHM26Pxs+iNgUO2SLKLKSgSkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5V3CIVGNIF6u5wn5MWn3emlq+OcypiP3MK3gqC/I7SOuivQeU
	SJ15GQGyy7UGBgFYSzme2X0hyowoVr0QCELZQjLv2jIFju5yuLwm2FGX
X-Gm-Gg: AeBDieuzu4bikDCgsnbERnlrre/jmb96WgTGHSAuZjZqMvrO42Gbt+0wahpUT2Fe++V
	lVJGUWpowDyWN9nzS8b29ukpK/6LQvzz3nQ4H7NoOMpyo2vi6gLeQocGtF0Nr494Uu6hi9zZR3B
	SjQLmX52u9husbYCytS7YSeZcoTP1NR+ZXE4yDnPtOAb+Iij/MrXicTnB94I44ljU7b4WSQK2tB
	bQNxvhAXmsxcoqOSUg1INMQpc4HpF+8ZNvSvPakhyhqAU7wMuSl3vPAKnHp9LStAsl3RAJTxEzb
	/V7RJGP9vkUkOFKNWt5EBsyS7Bu+5Mu497Hn9KX29C/GxlWLO6ucEg11isSFG19OigMJRrNMT1q
	g2McV/ci5J+acJh2YmisKIeom4I7+Jt4w3fIpoM6feGa+nqIfzYSPcx1voSpPLTDwMfthgjG+Zg
	ZoXUBslHNmgoLUgL7QpzOMdAbj2eyggjyRM/j3GGuDqSTn+xEiHSHvn5Cqud1a1zexnqv+cpvgP
	5w=
X-Received: by 2002:a05:600c:c494:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-48e51f32c35mr130076185e9.13.1778164676226;
        Thu, 07 May 2026 07:37:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538fad5fsm140430065e9.10.2026.05.07.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:37:55 -0700 (PDT)
Date: Thu, 7 May 2026 15:37:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org,
 aconole@redhat.com, Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets
 <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, "open list:OPENVSWITCH" <dev@openvswitch.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] net: openvswitch: decouple flow_table
 from ovs_mutex
Message-ID: <20260507153754.346d7274@pumpkin>
In-Reply-To: <b1820863-fd30-45b5-b03e-28225ea80780@redhat.com>
References: <20260505084253.998548-1-amorenoz@redhat.com>
	<20260505084253.998548-3-amorenoz@redhat.com>
	<b1820863-fd30-45b5-b03e-28225ea80780@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 157204EA67E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285360-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 7 May 2026 13:31:24 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 5/5/26 10:42 AM, Adrian Moreno wrote:
..
> > +/* Must be called with flow_table->lock held. */
> >  int ovs_flow_tbl_flush(struct flow_table *flow_table)
> >  {
> >  	struct table_instance *old_ti, *new_ti;
> >  	struct table_instance *old_ufid_ti, *new_ufid_ti;
> >  
> > +	ASSERT_OVS_TBL(flow_table);  
> 
> Minor nit: adding the assert and the comment is redundant. I think the
> assert alone would be better. There are other similar later occurrences.

There is no point adding an ASSERT() for a pointer being NULL.
The NULL pointer dereference does the same job and can be easier to
debug because all the registers are still live.

-- David

> 
> /P
> 
> 


