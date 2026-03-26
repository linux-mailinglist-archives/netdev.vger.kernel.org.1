Return-Path: <netdev+bounces-272136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QClRDjdixWkJ+AQAu9opvQ
	(envelope-from <netdev+bounces-272136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:43:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF22338A03
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A80F830E1EA6
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D604070F3;
	Thu, 26 Mar 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb5+RN/w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC24D401485
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542551; cv=none; b=AIrI6aQj/WJG5RdV6QdlINDSF42C8eqXDxCoQnbXM+4eOI2wJkFhv5pvBcVRk63Sx1vh0ONffeQCbDOd2fky1/327MncwazLUHM/VnzO24QQ1J5Drx4q1TsG3Fm9oTsd28gyXJRKAxRevZx7earz/Kb/5uiX0ykNhQEnhsHdBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542551; c=relaxed/simple;
	bh=z6GMWOCYmwQPpclwbRHQ3L8tkjcwK1pnli6GFBfiIKE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZiDcTDD9rAIrr2qnlYZDbf2LXgDqUptl6VWIresqMmi8yCGQ6F19nJkiXlkoyzo2heLQtruYql9HJUULNkS2r2mdWohqbxStWhYo2MBrshQQ6nifO9uph/BjV88WUD+i2YQJ/Qspp+p/VY3475aZXCHDc5LxVrs4dnqJodHH0SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb5+RN/w; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ae222d978so1287809d50.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774542549; x=1775147349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDlf2p6914NjJVCVaq2Q/Nq8XSjjhMKVxHPhxp+UG88=;
        b=Jb5+RN/wcmRrbnOKzgXeeDbTGMsRT1cr+jjEF+HdsswaqYWH9wBOTKkHp3MQ/Z/0iG
         KmcOQuVStTRWRh0vCysHuGOHtd7tkfUTHzXpIUJtP8Nc0TGmwrBw5QbsPEjO8FjoEA8N
         W+rcytTfs9K3Atk3eZ+dxwE4dSlAVOga9QOyBv2/nv0uJVivXhzLlHiMmxF/TNdC0xE4
         JjO5xiuz27vdWX9zno1Z6blJ30yXzLfRg9w1k5uY36O0j1wH4gBpXo093g2jlfAL4xyX
         ztXKRS5NRfJs+LJtPPdmiHMX+rRWk5adv0vl7IrYPg8b0XeYNMUcE4ZXivkmf40VCnav
         WsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542549; x=1775147349;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDlf2p6914NjJVCVaq2Q/Nq8XSjjhMKVxHPhxp+UG88=;
        b=cvs6whMaB9LHyBFdFxgG4BkJVHgeNxfgiizDCldIXQdh/kaFeLKrb7bab8GKMDHIto
         e4zjGCj9U3By8FnP2GGSlf97XtChzqBXd4FXfLkhT4O0N3BHetKnZ+p1Fs4HZqpK9yiz
         kLN77MZBgnUSLy/d0/g1kaIFWkuwndzREvuxsj57+LjU3mV91q01QPCNkPJSiQ8WIKJ8
         lneAXynmz9llXPqrsAxuLu7LWkYAeu7B3ngNYpkD+S9TNXul5Aq2s8baS2vo0Y3cj+g7
         2hn22tXb32hQEUrFwXTqz8qCllBMV7Jy/Mxdu+LiJArgAMyfJJkwgbXBL0powIOp9l5Z
         5hZw==
X-Forwarded-Encrypted: i=1; AJvYcCVE3gygtlWW0fZ72cVoSOp7W6si18RaZh++a589pVrvSm0cN3o6qaHHNXJLzWLVVPTEXW9rKBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJvWLlyzIqIFiOabYjKVVyigWQbDczJ6QKvV9Pv5bhJbPlk3s7
	3S7X8Pil+d25Lrsjo2bBSkeNru7Mr7iT/3CvZjP972wXLO4OXwXYc1lv
X-Gm-Gg: ATEYQzyDyXjEJ0jMEn13qr2Y372ZnHYq1B3fKN5fiskiVUQ1s9gLWfFhAia7PJJzDGC
	2FEoKbT6MJUfK8bMm90uS/9qHojwc70E4D9+GAazd+vLi87rMPTOOEM9Uf9CsYHpiSKYVdpUeko
	q4GMvLqr3MSaBmR+zhqw+XdMyzyvbMYhFqc5H/77EcOf+cATqe+qUPQJd55alFutofHRUlK8HGH
	s9+Tt7cNOV3kIgGGquPug4/6HB7E1FT/wM0cuCQs71r3rVEhCSCK9O3vCCHO+gR2KSSq1l726xg
	5lmvgBNMA9L98eVpX8bwFYIhiOubn7Mju/0gTLdKp49ArJ4L9hKYz6nKlCj71NTlJJoiMJamzjD
	vZldUjPF2Mz0akCNWxbdxyD+dOe+2em25p6mFwkFRqah3bUC7TIQwGq7USsynpvplIOXOcx1Jxo
	l8ZOtBW9GSOOtUuX14ZUIQJh+RlcA1xUZnf1L/ikDYutdTHR7e7Us3GLyAXE9XuidUaR0dHqGiY
	ziWMkD+QQ11sGw=
X-Received: by 2002:a53:e105:0:b0:64e:ba77:8412 with SMTP id 956f58d0204a3-64ee6185ff2mr5998843d50.73.1774542548777;
        Thu, 26 Mar 2026 09:29:08 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64ef58ca09csm1662948d50.5.2026.03.26.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:29:08 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:29:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Petr Machata <petrm@nvidia.com>, 
 Richard Gobert <richardbgobert@gmail.com>, 
 Anubhav Singh <anubhavsinggh@google.com>, 
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: linux-ppp@vger.kernel.org
Message-ID: <willemdebruijn.kernel.29bf4e0691478@gmail.com>
In-Reply-To: <20260326081127.61229-2-dqfext@gmail.com>
References: <20260326081127.61229-1-dqfext@gmail.com>
 <20260326081127.61229-2-dqfext@gmail.com>
Subject: Re: [RFC PATCH net-next v6 2/2] selftests: net: test PPPoE packets in
 gro.sh
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272136-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,nokia-bell-labs.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FF22338A03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qingfang Deng wrote:
> Add PPPoE test-cases to the GRO selftest.
> 
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> v6: new patch
> 
> I'm not sure if I should include all the existing IPv4/v6 tests for
> PPPoE. There are tests that hardcode ETH_HLEN as the NH offset, which
> are meant to test the L3 protocol, not the underlying protocol, and
> changing all of them seems too invasive.

Overall this change looks good to me. But indeed all the churn of

    (pppoe ? PPPOE_SES_HLEN : 0)
 
is a bit annoying. Left a few representative snippets below.
I think that could be avoided similar to MAX_HDR_LEN by having a
global definition and using that everywhere. Still a lot of churn, but
at least no repeated open-coded logic.

Also consider whether running all these tests again in PPPoE adds
value, if not, then indeed trim the tests to those that truly add
code coverage. 

> @@ -745,7 +777,7 @@ static void add_ipv4_ts_option(void *buf, void *optpkt)
>  	memcpy(optpkt + tcp_offset + optlen, buf + tcp_offset,
>  	       sizeof(struct tcphdr) + PAYLOAD_LEN);
>  
> -	iph = (struct iphdr *)(optpkt + ETH_HLEN);
> +	iph = (struct iphdr *)(optpkt + ETH_HLEN + (pppoe ? PPPOE_SES_HLEN : 0));
>  	iph->ihl = 5 + (optlen / 4);
>  	iph->tot_len = htons(ntohs(iph->tot_len) + optlen);
>  	iph->check = 0;
> @@ -755,7 +787,7 @@ static void add_ipv4_ts_option(void *buf, void *optpkt)
>  static void add_ipv6_exthdr(void *buf, void *optpkt, __u8 exthdr_type, char *ext_payload)
>  {
>  	struct ipv6_opt_hdr *exthdr = (struct ipv6_opt_hdr *)(optpkt + tcp_offset);
> -	struct ipv6hdr *iph = (struct ipv6hdr *)(optpkt + ETH_HLEN);
> +	struct ipv6hdr *iph = (struct ipv6hdr *)(optpkt + ETH_HLEN + (pppoe ? PPPOE_SES_HLEN : 0));
>  	char *exthdr_payload_start = (char *)(exthdr + 1);
>  
>  	exthdr->hdrlen = 0;



