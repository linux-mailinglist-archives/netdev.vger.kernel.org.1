Return-Path: <netdev+bounces-268539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL5TLRwvuWkYuAEAu9opvQ
	(envelope-from <netdev+bounces-268539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:38:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4022A80E4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 405ED3065311
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C70F3A6B98;
	Tue, 17 Mar 2026 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRhIAl2f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jhU5lRmo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FEB3A6B95
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743687; cv=none; b=oO9BtNcnqEOkQUH0vgaJ1u6XUD3R2EL5S+e72nKDP23HcF3JmpmYtPKbNw9HR+KOQhEP7PzaTox9aM05W6O+s/pUTbHqkbUDGD0KLregs+Fnj7UfUPhoK3zD60wcvkFeun5gEQBBdR8pI2hl/j2P2aEeVpLCa76CeR0NdYTwUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743687; c=relaxed/simple;
	bh=cOJ0pqLB05cW7l8D0d5y/xnlGOGTKB72z83QuCFoWlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ggw/869W42wSHlP9bQcHomGWu9SM4Phx09oxafau15YylD3+Vba4q07l8u9GPEhB4b0F2i1tVme9lhEGj9E6H7BkHkeE7WYqLmku3KSjEecbVw6kpP5cek4lfTxeg1wKPLC5QnFgtBLRFasCKKzmCJ80XLLl8Y/hWCnKpNfccmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRhIAl2f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jhU5lRmo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773743685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ny0IuTqhujPnnvktMKwVQKRIYww+FI37mlIAqoGoFS8=;
	b=CRhIAl2fIPD+9Zy9h0eoRCjxNxwJZCHNhieCDyVKw+pk0ulC2P8ZQ0r3WiqH4F/4t9+Jir
	RDCIYJcIzYKbORr69wetXv612iqpo43JDWxSPFZDSE+/5GiqtjwMB/VsgGJFdTq6BUZfLC
	4JaosOAdwLARoIXbDE5nd5UkMesDN1w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-Y4tGd5MNMeunHtE0yE1pDA-1; Tue, 17 Mar 2026 06:34:44 -0400
X-MC-Unique: Y4tGd5MNMeunHtE0yE1pDA-1
X-Mimecast-MFC-AGG-ID: Y4tGd5MNMeunHtE0yE1pDA_1773743683
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b41d45be4so361640f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773743683; x=1774348483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ny0IuTqhujPnnvktMKwVQKRIYww+FI37mlIAqoGoFS8=;
        b=jhU5lRmoFBsvE9mcPAHRQtqhz+tZgTxj6HqNeh47C2/ltxxWR2vWB7ck4X4SlGru0D
         c5rYqONkzbGUPKlbFAYIVRt1sOuBV6yyQeCJErqIf0vpp172ZYpMgvHxzcmLQ25KVPo6
         tNIzSurYa9nHVyWF5RlptqzbmavlzWGl425840CVOqbf6oxzQKeXjGTvMtZT4KF55HMF
         2MwVVDRxtbat5H8XKwkko91NHVhQBsfPv/dzLeqTtCV6BZzQiXeROJWYbho6DAPU+Vco
         QkEO+UBETXqW/2mEe4ooZ1wt8wgqU0SLbrWM1ynZsDklfWf3UjSLx+yiK0+Zkpl3p60y
         eNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773743683; x=1774348483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ny0IuTqhujPnnvktMKwVQKRIYww+FI37mlIAqoGoFS8=;
        b=WYQnj2v583aawSlxkGHYYKWRE1LLT0MvCRcJwg27bgGyfZeNpzgh9ZDKXw8ZBkDzA/
         BDRzFmVZ/cvEia5Z8gyhhzMbhLEbFIYazvMgXG6MmDgQ8+OwesmjoBIkW/HeSr5+H69o
         N03G4bmBw7m99KEtWMmJxvTdjx7GcCJaGDFV66ITbc/JdqKUNiivUgTwXYYlMbUbaTYe
         SYOmNgI1SnQm6SMrQK0Fx0gpOYbTvzVFzIsK7iyXAd68bHJvYRWISLyUkZueZhW7MbZF
         e87Kv1i8HKQyr5UtTMFdkd43AENwqlfvPuiU8PIhh4idSvy87s12TfFCxX4B2i1jxRP8
         w+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVudnLpxAUC6iDFonzfi1rjhal8JQW6DdQdLDqG9Nevkrg+THdCWTHmUpA80Z4GvxUQtUEfnJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7fi66rN0GXq3E12czcE6+QpXQfgEsm4jWoHn/QPvWxD6AsW5V
	6d6RDAOjTLV5RRMuHtwcOPoOUTNvxEcgAkUYiq6/DbKfd+tacc0lSXiTRxuJ4E5C77d/kaliSfN
	sHVjYTHJ7czq4RROR6BzVKWBRUqV2T/yZQezYVxA0FKk+Y7u2EXrRMze7tg==
X-Gm-Gg: ATEYQzxh29cVJjr/1UyWXL4gP8ha7TATVYHFFGesc4q34V7Eb0/29u1PS2C99mr0Ioz
	f8JBpe7atX6vWvocgtrovXywYGtFn0wnKGO/+/OdLQ8PNs3vj4aF0HJ3f5fqiAeg3NEgvVjt+QQ
	A+qF3cWNkDH1WbwwwhB7qfRJwY77V1nylKl13n6hspmNH99g47zDYGAo7CG0F0n1PlPvW6xQ/S6
	rVDipDi6+zSjXAylcQdzZsZsScyXhDfjceEJXkNWfcwUId3UaY1QNi1zF5UiCOSuY+zV/5H7Q0N
	mmeEzsrYoaNrv6rHaB9+9dNr/OSDS+SefO3JRLIBObivzIkMqJRsZyRRxIj9LXubn3eA6mXY354
	w1XYX++1099n6XDgsew9pnpc0sG2c6qJ0Dh0d9EuQROFRvaExzNZ+q3s=
X-Received: by 2002:a5d:5d06:0:b0:439:9812:35ea with SMTP id ffacd0b85a97d-43b498127a9mr5655196f8f.3.1773743682866;
        Tue, 17 Mar 2026 03:34:42 -0700 (PDT)
X-Received: by 2002:a5d:5d06:0:b0:439:9812:35ea with SMTP id ffacd0b85a97d-43b498127a9mr5655135f8f.3.1773743682342;
        Tue, 17 Mar 2026 03:34:42 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3e9a4fcdsm22271699f8f.8.2026.03.17.03.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 03:34:41 -0700 (PDT)
Message-ID: <19078c41-5ee8-402a-9b60-fc4ab0fb8ece@redhat.com>
Date: Tue, 17 Mar 2026 11:34:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] net: Use trace_invoke_##name() at guarded
 tracepoint call sites
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 dev@openvswitch.org, linux-sctp@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-5-vineeth@bitbyteword.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260312150523.2054552-5-vineeth@bitbyteword.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[goodmis.org,infradead.org,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,redhat.com,ovn.org,vger.kernel.org,openvswitch.org,lists.sourceforge.net];
	TAGGED_FROM(0.00)[bounces-268539-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email,bitbyteword.org:email]
X-Rspamd-Queue-Id: 6F4022A80E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 4:04 PM, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_invoke_foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_invoke_foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6

Side question: which is the merge plan here? since this patch depends on
1/15 I guess it's via the trace tree, am I correct?

/P


