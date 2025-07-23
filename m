Return-Path: <netdev+bounces-209276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453CFB0EE15
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754D6566E18
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36128283C8C;
	Wed, 23 Jul 2025 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Dobyz5Ug"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEEB283137
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261770; cv=none; b=Xehq9VsrL2EMfS/o6XEGSchvjSZghMbe3ZaL2Th/knE3iqwTWCAUjA4Xw5jzZmyJfkAfNweBh49oYRNwe1BiMXd+bqX/IKxR27IKHS1yEo8PMFuqyZpOUAdXw3joQ0FKDML4N2GhW0nMPFAI8ZzPd89X8HHboTUVW6VkP660CIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261770; c=relaxed/simple;
	bh=+ytYnD3luDBYq9P4nCMvymvEEpfDPNQbSLnTtC4hmEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTSDyb2o43wWmR7rliWCBfav++QI3jo8lEFLyqfCqHst8KgqcpdAjZGKXiXykgpKp5dT6R42rXgdUGOJmXcdR7Nwl5DR8CixLUQvDlSH5D6e+sVLyl6Ntlhy44wrPbfU6G/c4iEnxc4L/ek4Kr5azFccu4fHBimqZQHj2pHtMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Dobyz5Ug; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0d7b32322so1013271566b.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 02:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753261767; x=1753866567; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2zcV36T8m2bDfLjZ71K3Nn6DOnILgi1eLJ8ygProCpU=;
        b=Dobyz5UghswWZ3YrUZhnvIqA0N0jisQ50PXWi4Jd5OHY9bQpcxAeCgs7Les7ttqH05
         0TkhQKY0fO7fVcMVN98sEvrT+cFUunfm7sVcJD8YeulARXmsl3aaJ9YPl02FoMFAmOH2
         T3xChhKW7rDypPUM33jhMN7oekKNlIaN0N3OpADSerXdlkTslYt4a53uAi4CewWUNSsJ
         pwVIgiSJP94FI6TU9Ag4LOHfxCcx5n7k6inxbxZgHF1pA/Nm3nICpL+5rgwRSUq7eqXY
         NqYSQpXm40SqgWbYP1cejOaAbr9nldxqO0uomtDV/bkM/52xyxFx9aVJjnJdZd9BHMo2
         sSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753261767; x=1753866567;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zcV36T8m2bDfLjZ71K3Nn6DOnILgi1eLJ8ygProCpU=;
        b=SvLvgXI6KWuUGtXWZH6BTlafaCS7MDtT42Zjzw8sv8hRbvb7k+oO7GxlI49nXlNaVg
         zh9F3omkvq96YeDLavl2tQGe3JDfKQ1MRsvIzKJJ7cNybEtDQJ88/3/kTGMzWYK+f5hN
         bPqaYmZLRxkqeQzLJfLTJG0CbvSKaob7vpusBZZcqIMBtluype029kq+GKLHTPxxLE4S
         PaF7CrAf3IZUUBEQtO36VtXaTVSU3NmT4XUrM8Rj/EvwXSUJkAIxAecKLSiAm26Ty+Bc
         AiN3DFLkQ+sWgfV7c/b9JJvRSbN5IbHm2TEzVGlepUoSn7cycsHH/erBUuvpsWJTiGt+
         cQ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWOc0p9dNKYbsHW4rv2Xkg/VVZbNczHGghS+4ffLykKfr1PQX5kmNaS3wlKVrogXEBhVdqJt0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx5CiHQqJZLAZwnvDdUckEUYGbejzBPJjox53eKJR8nS38PWdy
	P+Ti60YgSqlmZLaMmmjR9TGd1Do9gXlkiXuf2s4zi0fdUP3fP2D0/QwmEa76881cBnM=
X-Gm-Gg: ASbGncsnkQjAY7h/lMKoWMy9yw3Lj0QRMQ5HcIbawqPmQh/kQJQbGibFnAm5CWIlFlL
	d7JWYSypGiCyKOCkZoE1r4Wwti481zqyNJju0TSuicN6awoKLpCs1lgjj7x57HhTbwIWqb5kiOK
	kNOiJyr+fx7OPCvHACqPVg2ccP1IIeKfTju94+w89Ou9iVmyKIeY8wlMsOINX39KYHL1e3CFGQ6
	XGnMNrYevm1Thyocrw//47EIkFZfIlwcRhutgfwcnmmLD3XLjQW8XZIfuTI8dT8WtGa73/ofGYU
	GgM/rdfxivLE+BiX94VL+QjARn8I9w5XQNg500tLAmCOFyykSkO1j73iieu8oR5DSLE8wSWgL/h
	1JYHDJ1ytMHmgu2Q=
X-Google-Smtp-Source: AGHT+IFppVFkyEpOyB0CPplf4xKmqV75wZQ/fIWHvCo3wyJNQ+QDWQbCFvBJ3QOnmHHOIlenUkvO2w==
X-Received: by 2002:a17:907:1ca9:b0:ae0:cadc:e745 with SMTP id a640c23a62f3a-af2f8e51179mr201694266b.40.1753261766446;
        Wed, 23 Jul 2025 02:09:26 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d5255sm1008043966b.40.2025.07.23.02.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:09:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,
  Daniel Borkmann <daniel@iogearbox.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Jesper Dangaard
 Brouer <hawk@kernel.org>,  Jesse Brandeburg <jbrandeburg@cloudflare.com>,
  Joanne Koong <joannelkoong@gmail.com>,  Lorenzo Bianconi
 <lorenzo@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,  Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,  Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v3 10/10] selftests/bpf: Cover read/write to
 skb metadata at an offset
In-Reply-To: <addca8ce8c3c51bbd147175406e9da84fbc9c1e7.camel@gmail.com>
	(Eduard Zingerman's message of "Tue, 22 Jul 2025 13:30:05 -0700")
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	<20250721-skb-metadata-thru-dynptr-v3-10-e92be5534174@cloudflare.com>
	<addca8ce8c3c51bbd147175406e9da84fbc9c1e7.camel@gmail.com>
Date: Wed, 23 Jul 2025 11:09:24 +0200
Message-ID: <87a54vxohn.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 22, 2025 at 01:30 PM -07, Eduard Zingerman wrote:
> On Mon, 2025-07-21 at 12:52 +0200, Jakub Sitnicki wrote:
>> Exercise r/w access to skb metadata through an offset-adjusted dynptr,
>> read/write helper with an offset argument, and a slice starting at an
>> offset.
>> 
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>
> Maybe also add a test case checking error conditions for out of bounds
> metadata access?

Crossed my mind. I was on the fence here, asking myself:

do we need a test for dynptr OOB checks for each dynptr kind?

I decided at that time that we don't, but happy to add it. Doesn't hurt.

