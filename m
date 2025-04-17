Return-Path: <netdev+bounces-183614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F66A91491
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F78017D9C8
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 06:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D298A22332D;
	Thu, 17 Apr 2025 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0aTtXrv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D99223323
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873051; cv=none; b=SI/iJc70EFtQd6h0O8xGAvrv5E0CqIrA9qEuPGsE8tKyzSzEAlOs/1GhL8VZpsZt16tNVC0YGfxBHWIb4h+WwJTqVr4CQnv/n/IIQpCNBBTOjIsqi4xAtwdZ8NrAHuLDtVcJpnPQST9vH8tNlJdxX+eNhK3/E+n+0VKWXlFdzws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873051; c=relaxed/simple;
	bh=jjODyzoHgOaSkMOizAfMka0/yn10076bTRY95dAS8m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q157LE68VurGF/9eBoxgwPr/2Z/vDo+OlgjJEfn03ks5Zb3zYEkouxBnXo4ieQVLeip8yYteIBdBLw9rBpFmR5iAHluAkuBDEU8KvTnLMfeVhMSJcSI4CZAB+Q8Dy4zuulyiE/bZhkxP43H1RD7zIZSVA8/uPOLtEyUh7SFl8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0aTtXrv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744873048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjODyzoHgOaSkMOizAfMka0/yn10076bTRY95dAS8m8=;
	b=c0aTtXrvutl860470MPV/z/GeLwDm1Ax8S8u7g3PoGWkurxmWRh1PDayRou3Dwv8vRbgYI
	whTNwoRNl30orJ2kpUuW6hvNgVZOU5OMK8G0hU2+mBcrIXNrbZnMsEnBQlevA1hr6uuyUW
	m2ip6Z/eTkU/iGN2OR5S24pLvnuPU1Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-10hrynEsMFKorXATgZiOpw-1; Thu, 17 Apr 2025 02:57:27 -0400
X-MC-Unique: 10hrynEsMFKorXATgZiOpw-1
X-Mimecast-MFC-AGG-ID: 10hrynEsMFKorXATgZiOpw_1744873046
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39c184b20a2so192155f8f.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 23:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744873046; x=1745477846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjODyzoHgOaSkMOizAfMka0/yn10076bTRY95dAS8m8=;
        b=gov5kwZJqvNduW2HGL3No078yEYa8nHqo+d0+9KgxUIaUlpnilpce3bODdeAPwJd68
         T9MdD+lGg6WQuPvhW40TWDSQ7bn4JN85X6ErxaNBNpDZqTjtQ5QC4Z7hB8cz4JtcTfZ7
         W1hF/lIFEJjAPEOpaIPjS+XakWscOTngri0iK5htclwV+w2iBe5Kbs48vcAPtMzEhsQ0
         A3cWQR0xsGkYw3xTFgVrfQs52TQjU0LTssq/xujuvozJMNfIzm10h56xFADL/OCU1lom
         9qivj82/7u0tHCxxBmfPuDboxID1CGryubBrU5OlHrBJ2gJ+sEzBSq7jTSHwZd7TIVrO
         0tQg==
X-Gm-Message-State: AOJu0Yx9eDcSrjVuK/iNRkUNveD2geqQR1tjYQ05FJTNLUGJ6CpRapd0
	atHnOfE+lKnHCRvntV9Fl548fydRXL3R+x4gIsAPJxnetzSDgK+iOnvYZuP3HV7ss4byf/MA6uM
	s1wMxRnhoCKNyyIafoi/4feg3TgsjgM67Jm+Pq0oMd3EToUB06e1Nqw==
X-Gm-Gg: ASbGncsUmfl892p71yshAXWEavbvRnbpFp8ucvALeRhYu4GS74TtjQBOn+8KuN7PF0g
	6ybxggsLEZeFsdRlGNuxgKnFFG2/CNsrxfgnGX5vpluzlvtYmGGZ8PsMETqJygmlTDAlOkYw3Tm
	NPR9VdAu6bd52L9Hc04wjC6MVN6x9sU7W56zl/JkR4dQ7jvrJb+5tuaLt+CQFeSg8pwNhKCCHnZ
	57K4lmhNzWp3c1V+ciY7ZRoj4kNIbH4HnSnyW8wjQg9L7YIvLN6TZXx75oxhXcLtkTuzuiiB9MO
	GI7v6gNbjfYGgycokoYpF77QMcoLYTBEzgk2+4AnXg==
X-Received: by 2002:a5d:598e:0:b0:39e:e557:7d9 with SMTP id ffacd0b85a97d-39ee5b12f6amr4246225f8f.5.1744873046367;
        Wed, 16 Apr 2025 23:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxeneD4PU1badohm8V9WmJtKj9YkZnOXQdqdLY0Y/Fs91DJ14HKRGByKHiwMz/4SXoc3HdGw==
X-Received: by 2002:a5d:598e:0:b0:39e:e557:7d9 with SMTP id ffacd0b85a97d-39ee5b12f6amr4246204f8f.5.1744873046049;
        Wed, 16 Apr 2025 23:57:26 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43ce3bsm19526728f8f.66.2025.04.16.23.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 23:57:25 -0700 (PDT)
Message-ID: <67a977bc-a4b9-4c8b-bf2f-9e9e6bb0811e@redhat.com>
Date: Thu, 17 Apr 2025 08:57:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
To: Breno Leitao <leitao@debian.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, yonghong.song@linux.dev,
 song@kernel.org, kernel-team@meta.com
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 9:23 PM, Breno Leitao wrote:
> Add a lightweight tracepoint to monitor UDP send message operations,
> similar to the recently introduced tcp_sendmsg_locked() trace event in
> commit 0f08335ade712 ("trace: tcp: Add tracepoint for
> tcp_sendmsg_locked()")

Why is it needed? what would add on top of a plain perf probe, which
will be always available for such function with such argument, as the
function can't be inlined?

Thanks,

Paolo


