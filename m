Return-Path: <netdev+bounces-302643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PgVrEl10QmpT7gkAu9opvQ
	(envelope-from <netdev+bounces-302643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:34:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D65A46DB443
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:34:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DAO0MwtB;
	dkim=pass header.d=redhat.com header.s=google header.b=YF3y3nRg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302643-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302643-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFBD8309BFC3
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B597D40B6E3;
	Mon, 29 Jun 2026 13:15:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D6140B6C9
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 13:15:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738903; cv=none; b=AZEy7njGygZ9LjKzcB8LPtE88z5LTDJTpi5piIEiQhXvD6k4Uhutth0SnH4WeguQnog5sLAQztB3wL3ClKtsBG0C1XNqgxaXDlUdQ/ImUQ7/n2KoJMCHlSituvra7OYiOke+FdYlPiM6MOstlBE0hNXw1uXVIQInZPVrDJKiCDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738903; c=relaxed/simple;
	bh=V+ip7hOaNxQN+PupY79i45O/+JJVNlH3/T229lk4eXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRxtgIf6OVFP1TtPP9T9m329HKkJEqZYVOuQVfa0XROmNn5kopPiw5Wfw+5nkdEdOf0b/3GTvDlLfSx36CfDW2X0/EWam3EKbdUcECsyLFDA1MWicGksgK7iPS3chmHFGVOA0961vhzKVmHusa20fOHrJLqWzPW002GxmFs/xd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAO0MwtB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YF3y3nRg; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782738901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxtVeyiP7HimsNveV07yo+ZQVotxy5gp97RrKjEG4ko=;
	b=DAO0MwtBetxvn7P8gyekpyeQb4uhAfqt13YP4SdxlT3FGacqjo8s42oleXEBuISpHAW/TI
	751K0VpZHq7HdaoUrHXqPGbZa+h639O5eHVXYiZoBrrc4tagtswN5YBsBuj1RlYsK6ZMMO
	T0bfzZw7g7nRiyztWQ0RHNqrEUPh/5E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-2dpFCLVfMOKrvmyEvKPFIg-1; Mon, 29 Jun 2026 09:14:59 -0400
X-MC-Unique: 2dpFCLVfMOKrvmyEvKPFIg-1
X-Mimecast-MFC-AGG-ID: 2dpFCLVfMOKrvmyEvKPFIg_1782738899
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-471c76f357aso1285339f8f.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782738898; x=1783343698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxtVeyiP7HimsNveV07yo+ZQVotxy5gp97RrKjEG4ko=;
        b=YF3y3nRgm0S6aEsOkrAxxEA7YY4Vj++oV9di+vC9qg32jxwFwjlyOP2mdYQeITpyBE
         dN6t0+bQnBLbeqKNhyBNjiINJ41MSLsoMFXvKRONwz61O6tBOqrHRBURgd2323ItOrs9
         HHJqjd+9SBsK5VRdqdPqXcD2TqRq5BAWOj9rMcRnVlORK3IWEMdEvbayBDahbln7TCPN
         U+AqD6eiS4LekN+dPTF94qz2H+QoLIruG2GjwI+J9f7Yhl6ekouFtZrSH06Fz2syB2VE
         KyOUPOu0biE6rf+1r74PfsHyxMazy8FF3TJ/4VmVJbEI/ln+SndFlpvPRhBvLweKT8yS
         2M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738898; x=1783343698;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxtVeyiP7HimsNveV07yo+ZQVotxy5gp97RrKjEG4ko=;
        b=WqYUB+XKLXhI2/CkQyRT6UCNenWwDyNF6voAnO/2P6xMXA/KGHbsiU/liedFHspQg4
         lfX/fYNbKh5oignvrYFQpG0EuGEXbhjIRefsXmYCzY3RWrK4MeJnN8jvjY3dhup2PQCw
         +YPgFgYVpNjgUSNogKd2xiu/888u/JTngDbgmmsYVq0zeahvKnfY1H2DqlSGiPiWTfkZ
         Y2X4NIer+/yYSkSv+KrHS4b94gnkNSXGGh8XtG8SSjHB6Sr2J7sJsXMaKX1D7/cRRDe0
         io74KdtDz1ARLDIwnoNU4es5qfAcNYdgoEfumiwfKLBhgVHZ28iPnAP3vbohIvpsritc
         1kEw==
X-Forwarded-Encrypted: i=1; AFNElJ/OpDSwFsaKCt384bpvuCi+MzaMOxfOX3MWWgsjZ9mDWPiePIzP9+Zi1WFTB2v7/PAxWTaQJWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEV2beJ8w06I0XphpGVlYThbaWQzjD7fM8V1FR5KvvagaV9C+8
	F0+dKGy9/V5nFbFMOVbg9osHkqIX/DEw76lWZYGVoBGfhhQWUDwBaOlhGDZTJV5I+6FQZwcKUT9
	hiVZa+1MS6yNd/ikycJ851qgQVoGwtdM8OaiqcnF4+6rRICEDFjTYnP5DLw==
X-Gm-Gg: AfdE7cmRdQodpk0qS2DiVC0ZY/yGWRM71tZOoFHsyorknvEZx5XxoWs8K8Z67MOnGqP
	YWCp09jYiu6H9cFSXbS9n83ptaUMc2qvH0QTk2KBkI/CjJJ0VwVNSrVUzw6dzPfKJVR9Xlir3kU
	6gaWBDZAus+77au1+uJrjQy0CjQ5dkq27D0+zFyAV1FyrYvoIPu8Yo7OsOD+CeJ4R3SgNeFRpr1
	9bCBJmmDGJ90CHNDOfc3PB4197LA6gwQihy8nAO09JRz1Ivqra+lsHx2vZdtWwmEYVoRMyZieTy
	sZZRv1/f1jXIVDjp4E7fyxgT4R/ywmVfquWrO83vna29saMNwGHaSExIEhoFR79B3icqtcs5HRW
	u1Mdsv0/oQP6phEWIu/a+j1Im09+1HCCgNbYouox8Ry+9BL5JPvefKdQbpsnV8bRSWa5VmXGGdM
	0OiskWzHjdwg==
X-Received: by 2002:a05:600c:34c1:b0:493:a61a:a3bb with SMTP id 5b1f17b1804b1-493a61aa533mr85901665e9.22.1782738898539;
        Mon, 29 Jun 2026 06:14:58 -0700 (PDT)
X-Received: by 2002:a05:600c:34c1:b0:493:a61a:a3bb with SMTP id 5b1f17b1804b1-493a61aa533mr85901235e9.22.1782738898043;
        Mon, 29 Jun 2026 06:14:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c278ab2sm182095195e9.1.2026.06.29.06.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 06:14:57 -0700 (PDT)
Message-ID: <2edcb1cd-f2db-4d0c-a0e3-fd2b4dd820fe@redhat.com>
Date: Mon, 29 Jun 2026 15:14:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: only honor zero-length DATA_FIN when a mapping is
 present
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 mptcp@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260617215725.1116295-1-michael.bommarito@gmail.com>
 <3ad5bba8-18b9-48a6-94e0-99d958f23984@redhat.com>
 <CAJJ9bXw4Xz=Y8Jt1KxSTA-0EOfKU829zGF7nJcfwWPQjh4ZGyg@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAJJ9bXw4Xz=Y8Jt1KxSTA-0EOfKU829zGF7nJcfwWPQjh4ZGyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302643-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:mptcp@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D65A46DB443

On 6/29/26 1:00 PM, Michael Bommarito wrote:
> On Mon, Jun 29, 2026 at 5:50 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> Isn't this fixed by commit 5e939544f9d2 ("mptcp: fix uninit-value in
>> mptcp_established_options") ?
> 
> I did the reproduction ~10 days ago on linus's latest, so definitely
> still reproducing.  I think 5e939544f9d2 was on the TX side and this
> is about the RX option path, so they don't overlap on flows either.


Right.

AFAICS the RFC is a little vague about enforcing meaningful flags
combination.

I think it would be better to avoid another conditional while processing
incoming ack. Does the following solve the issue? 

Thanks!

---
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0ca60314d667..b924209a9b74 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -157,7 +157,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		ptr++;
 
 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
-		mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 		mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
@@ -178,6 +177,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		}
 
 		if (mp_opt->use_map) {
+			mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 			if (mp_opt->dsn64)
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else


