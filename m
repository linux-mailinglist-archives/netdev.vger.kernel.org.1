Return-Path: <netdev+bounces-270126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ+ICxnpvWmKDgMAu9opvQ
	(envelope-from <netdev+bounces-270126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:40:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4CA2E29C4
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 461F23067402
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C05F31F984;
	Sat, 21 Mar 2026 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5OoxHkw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030DE3019D6
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774053591; cv=none; b=CYVKILvEctOkguo1gKmZJadJlaiYXrebTLnhvEWOSpEOSOz/67UVRH+mZw0hcmbyAREDejN/D4/kdM26GSsnUNOQux620zave+rPOaj7wmlNTWPZoZqL+YCmWJxmvw/4mcUdMpq358C4KPvG0hoUmRTOUlo8TkcnpnFiQaaX+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774053591; c=relaxed/simple;
	bh=SS4Yt3zFzImyyeOq4jcHWSPrcqDrkh4/v4ZlbJcO+xA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pMJ9SpV+rderGEjhstLQwWINWGquUUL6ph9XFCRCnIm9PBV9Xe20c56pHsOSx13H+oCMvcApiZD4riXqQO6S0nZsAJisPcLCVlGI2KYwD/DTTv+Tj39DPNsJjpck5KtsNc2bjX8il6GP7DSq2LKhooSr4CkPE4p1ob7DXptUir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5OoxHkw; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79827d28fc4so22829717b3.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774053588; x=1774658388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0ZPEi4qQzDtpNwH8vlSQQ5rqmko0ODy6PBRiyAMQkQ=;
        b=B5OoxHkwxnlvaTLoog/dopbf6FL7vyOwZl6qc4KY0bejmGuou9k3PaPllfMWKMIs1M
         4Sq3a/N6EKprxtha/yYj++FvJDGqmh2JVedadp9OfgvoUVt6PLuos/QxW80xZqQThcKF
         G0pL3LTOGEPst6WONBG57fqAxdk/GzERD6wDpuxR3Jelqca3WjT905+XHQpQZeAgxNSj
         P0819ZSxsCkirvwkYH+HGnElbQ7I5wxuXqdXvkr+NhsqG0GJgwX0dZOZS7l5jvrDoT6n
         bMClmVlWD4AuuLR//s1tBqC/nCv8pKdB7izePi5AM0hYdID0YK5MlX2gjXc558nWuMP7
         73XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774053588; x=1774658388;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0ZPEi4qQzDtpNwH8vlSQQ5rqmko0ODy6PBRiyAMQkQ=;
        b=X7vJsGxjkqiKAvdeVGctvoBK0+7MCKgch2uZdWY/oO/hsYDWVX7JNjqevyesjHPsU6
         W+5yWpeCDMEN9TI29Z3GCtdKLubAEtoZ5GBHesAS0Yay0cDua67Qn9g0gdVIRdBTz/jH
         APTqr0bkoWwY9HktHJPzpTlFZBFg9ibi/QTfe5DpNcVjN5FGND3OfSWqX0ZcH14EHNLu
         29YCERmU+FuzxzNergfn9AJF0KJbk5eNcAkk/3YffHAY1mlnGHp7tFP6YuWngGeDRzV7
         zJgxXnjul6jnZ5GvUh7fVLPo7qnc/FB5BY3X8mgowhAmcTvN3O7JZNNUVKUPISBJ8JeV
         5YuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyNdguQLaOG5RphRWf1Va6Eaj1JN9pJ/TnuuOTlBBNJUvh6A02Lo+3du54xPQy61Kx2cU8vbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAI1dPTMq8LH8JHVa5I1kVg8dCACd3vLnopm0zzj2cLCYH32+c
	BnLpE5kp+4RXM9LMGFblaKjgWtmiPv1HmNdjEnUaZM16viswEy9GTUfq
X-Gm-Gg: ATEYQzz5ZNsvtfqpfXCHXiVrmqq+LFxfJ+epZi4yGrhVUqTGANnmhkuz1T/b5Aj7FCN
	7lGwIk2DwGT5/GbRcbZgUPCcUDwPWo1Ta5paxZ75/TW4hiuGe7qbzizyjJ7uYwa8jts3hi7UBFm
	ExlaSTOfjCwPa24H+eUsMixGpmjtb1K0WMbKSTY8usjqDnLEgChq1i79mt/JWva7eFMytbhHBJj
	d0EM1cqFKiZEQcxFCtsrSzidsX5SLYLHRfIYj7fKPZNj/vtHOVbLWVPlNvXySkmoyaavc36reZY
	+7sDLb3BkN801YoI5B3Xbf4F0eseBfO80NfbraIN/xq4ej0QhvsbsoTJxXdYVg/B9VQ+jHjS4Jf
	r3pd4YC9WB/Zv8DxWrh4DmSV//wnNfhMRV+Xh7foKCiybvuFavA4YdslisEp4HKzIhnef3i0jMo
	gYapNFRb1DQ9xFqjmasouhX9PNnYyTfyaay3TxqKGvGi6QSWfmFwTE4Ca0ZULotXJqTpfhcsjwU
	G9a
X-Received: by 2002:a05:690c:1a:b0:79a:42f3:ff9f with SMTP id 00721157ae682-79a90c1cd7fmr52792637b3.56.1774053587704;
        Fri, 20 Mar 2026 17:39:47 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a903a2d78sm24684557b3.4.2026.03.20.17.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:39:47 -0700 (PDT)
Date: Fri, 20 Mar 2026 20:39:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.37ed1c90f7b55@gmail.com>
In-Reply-To: <20260318134242.2725749-3-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-3-nhudson@akamai.com>
Subject: Re: [PATCH v2 2/5] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel
 decapsulation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270126-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B4CA2E29C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> Add new bpf_skb_adjust_room() decapsulation flags:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_GRE
> - BPF_F_ADJ_ROOM_DECAP_L4_UDP
> - BPF_F_ADJ_ROOM_DECAP_IPXIP4
> - BPF_F_ADJ_ROOM_DECAP_IPXIP6
> 
> These flags let BPF programs describe which tunnel layer is being
> removed, so later changes can update tunnel-related GSO state
> accordingly during decapsulation.
> 
> This patch only introduces the UAPI flag definitions and helper
> documentation.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

