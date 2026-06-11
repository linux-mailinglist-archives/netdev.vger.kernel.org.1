Return-Path: <netdev+bounces-298251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aez1FnXxKmo2zwMAu9opvQ
	(envelope-from <netdev+bounces-298251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:33:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F6C674045
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:33:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rHFYjUZJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298251-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298251-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2486D3572DB1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5666E4BCACA;
	Thu, 11 Jun 2026 17:18:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C847A0DC
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:18:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198313; cv=none; b=MtR+Y1dcTGcR3ECGFW0979GPegpBeai4Lnxn9ZYEVsAuhhTYyXXf8WuvyZQ6Qh2XvN4VlPqOmhVjPUoRnkM5oHFHsqD1L7YobxKuA9udxM8Zg/To26idXoT6S9WNrKbJqexP21V7o38IbTJ1EV01mOgief8abCqbOH83iHnaiqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198313; c=relaxed/simple;
	bh=kAobYEkJDMjkUITJUMNyBriLzXiAe6UXFHqVuVHGqxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE83Q93KH2sR/9RFLce7zUFPKSz2M+LEB2+EiHosIL5fmY1HpZSJWaZKM82WfU/yxVx1SbqkABnOSYZF/15IOMPCtg0yCA28X3CUoeyZmyjJPi/MijOTvwj4eI/JbO2Y0T5h5h9+rL/hkMYJhvf1tx+A5jpB6fohAta1B6Ish4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHFYjUZJ; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so803795e9.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781198305; x=1781803105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AoP+cy2ffp1XgHOvwchIi8ndfKfAxNydtkxTWle4y9Q=;
        b=rHFYjUZJM3ER+3l1P5F7c0asHSesLMxBRreOo5xHxWaSpz5JFbBzSMheMvRwtGY00C
         ED6S7FFQjyxwzgtkdjR88vGS7XIYkOVT0KpYt/z51EXpm28ub6yH6PD0bybk7sWq8I2M
         ecwjpl6yPxPt6/rxsk1GR3LilFiqDQxP9zC19aT99jlOAbRqai6b19Q90bac7pHJLq0D
         trRjI1vV50CL7W94D7Wh/+97+eft9R2v1yhMg9dq0GIW0MiTfbt0PjPyyru+aMKNKqg7
         YxxXM2IwzCEpfz6NQ6rAs/eD+CfEpnQjTJB70WgYyVMfSXQvQYIJ07IakbCQ2hr+c4to
         mVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198305; x=1781803105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoP+cy2ffp1XgHOvwchIi8ndfKfAxNydtkxTWle4y9Q=;
        b=hud2B7TxHDWCMLZ4D32/DNBaLhIk8tF/T0m31nUICwQgPwyYdWZC8KbKgjgcKw8eYy
         Sl3A8s3M2RKaEi8j19VX4S/GqmZJJGZ5Jvqt2FO9pJG9QFqw9O404NoIStZKNLzYPshk
         wDjxT/lf2yrrCFIarWSziWl1u8y9tLhQVQkd1ee+MYJCrIRemlnDaTQMMJXzuviG7kbl
         evNcU/AKaZRNQ5t9OM6CATv8A3Z137gWYXrGClUZZLt+FiEbPBDZ2ycAWnc8wNr57rI/
         zi3OzluDVm+mQgNlOtefD9gAJx1Zc+8bGvRzQIAs2osnOyhEaDHbbnmVmzGEy4LCeEp+
         NsaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+udw/Ud/YRVVQX+h1LIwdcf1Q7YImblMyKvOY8t0XGidvO8BpwN2eh/5lDdBDUF983pCkfxnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX15K8KEJGIHDBncqFlXhgu1bWZoLfI8qOvo/u7G0js5VZoQxZ
	N5dmD4MPEpVWrc3BAVmIMJS3jMGsWEvXvkOdjChwWlLndo81Z4RUrV7eYmRdeHmE
X-Gm-Gg: Acq92OFhVUBd9c1wTtthWnn7J+MtcvAC7085YTnX6dLpwNEMDZB6Gjyd2Ovl4lLaqW4
	scqJmXovIpNRw0DKEXtOz9mM78+hhqgkt791S7bTnONugUQ+AqeMoyydhkdqG/HTbGyf0wD9Y3k
	JeIuukbx3+sAFHw0dre4EBx2RW3foFzM52azTIEmX539CMRgwQjmzSNtxMhHioimF4rMRFPpE4S
	vvTFhSKtRFn2PXsgkmCe3vdvJLnlGP4HzJ2L505l/kgJDc5gk3Ix+WrKI91gWflt7w9wwdAtmea
	tGS77+ckbaJt+309lIPy3EyLdaQXED+jAq89Dykwwb3UYlCMqGPytKWAqWB/Sn901d5A4q7MhHb
	E0L0L0Anu47vzuVqOT4Lqp27rV6KmbKavGH8cYLUGndZVsBurvYDiFfpglMGWk8IoPNPier6uSl
	8hHLAy/HaQ43942YXAyMVTr1WEYj/TK0bIthbpFYiaW4Uto2s9mFcKNKgaJ7o=
X-Received: by 2002:a05:600c:4e04:b0:490:b9d3:a9ce with SMTP id 5b1f17b1804b1-490e5640aa8mr56905655e9.30.1781198305135;
        Thu, 11 Jun 2026 10:18:25 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5b2e2404.dip0.t-ipconnect.de. [91.46.36.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606c10435dsm335137f8f.35.2026.06.11.10.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:18:24 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 0C018319F7E6; Thu, 11 Jun 2026 19:18:24 +0200 (CEST)
Date: Thu, 11 Jun 2026 19:18:23 +0200
From: Simon Baatz <gmbnomis@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next v2 05/15] tcp: allow mptcp to drop TS for some
 packets
Message-ID: <airt3_dPSfV54Aph@gandalf.schnuecks.de>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
 <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-5-758e7ca73f4d@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298251-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8F6C674045

Hi Matt,

On Fri, Jun 05, 2026 at 07:21:49PM +1000, Matthieu Baerts (NGI0) wrote:
> With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
> taking 30 bytes, the 40-byte limit for the TCP options is reached. In
> this case, it is then not possible to send the address signal.
> 
> The idea is to let MPTCP dropping the TCP-timestamps option for some
> specific packets, to be able to send some specific pure ACK carrying >28
> bytes of MPTCP options, like with this specific ADD_ADDR. A new
> parameter is passed from tcp_established_options to the MPTCP side to
> indicate if the TCP TS option is used, and if it should be dropped. The
> next commit implements the part on MPTCP side, but split into two
> patches to help TCP maintainers to identify the modifications on TCP
> side. This feature will be controlled by a new add_addr_v6_port_drop_ts
> MPTCP sysctl knob.
> 
> It is important to keep in mind that dropping the TCP timestamps option
> for one packet of the connection could eventually disrupt some
> middleboxes: even if it should be unlikely, they could drop the packet
> or even block the connection. That's why this new feature will be
> controlled by a sysctl knob.

RFC 7323 (which obsoletes RFC 1323) specifies an "all or nothing"
approach for the TS option.  Section 3.2 states:

   Once TSopt has been successfully negotiated, that is both <SYN> and
   <SYN,ACK> contain TSopt, the TSopt MUST be sent in every non-<RST>
   segment for the duration of the connection, [...] If a
   non-<RST> segment is received without a TSopt, a TCP SHOULD silently
   drop the segment.

So, selectively omitting the TS option on established subflows
appears to go against RFC 7323 at the TCP level.  Do we consider that
an acceptable deviation for MPTCP subflows?

(Maybe I am missing something obvious here, but I couldn't find any
prior discussion on this aspect.)

 
-- 
Simon Baatz <gmbnomis@gmail.com>

