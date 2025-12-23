Return-Path: <netdev+bounces-245788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6600ACD7F5F
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 073BE303BBD0
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 03:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96C62D4816;
	Tue, 23 Dec 2025 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOJs8TTA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FE92D1F6B
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766460169; cv=none; b=ZoD5Djse8kUgSBtsOEesURbzavBsEbLhTFUML+TO/9j6D9DGaowE623kFmTXRHCNx4nqI/xqzVijXkF1AI59XWIBmEMEZGRaIdnIdvYxGmsWdWqWVUiSZqPMR7JCHZ4mUc0hNG/Fj1SeGKnM/nuT00a/7hWpvlNYOMXZa6n0mRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766460169; c=relaxed/simple;
	bh=nXx4iU/G89xerhbNe+u8rqRV/ooGUpUr+zBdOwqNUIk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WuSTggxN5yHVNbzPfc9wFc/j2NZCV2HojnQEEHvanSzrEnFKmLPPLG+uIUUc4NxtoXPypAz+/IW0BFPuhpVZWXpPWQaBC/kcFVs7lCQS7px2SO03K2sDHdSHll3dnEs6fu0JDJlCvuGpcCgl7ME3lfB5kEeNqKDD+uITTRwUwV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOJs8TTA; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so4005871b3a.3
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 19:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766460166; x=1767064966; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIaw2BBgy4X6/8TUgYX4ddYdgedGRr8vnnHyY6AzWWg=;
        b=OOJs8TTA9zmASvFlalfZRRHcw7yjthb+sktasAWSRJyLbmTTDv1yaZ7LIbgFhJYnZT
         nfUzuSnWLKv2q1ygvKeNTVKLf2wR5OBafiWucKTrG2UYbw8+y0peq9wZxuPrhDKLvptO
         gnnmC/8tur1l8TywRFHit5z2BnmOEzuCgYE8TtrdChDS9mqecZrUwIdOxWT1U5vyKSMW
         kTResLiGzZJtxMkhmWAILe55gGIXsVFEvuiBNWDV00YqEnySMmjDxKIFhcCPF6IBJXqb
         /0cDYRXtyIIq5GKcd4JK9xw7mCGR/WvmKV0LRzKwaGQ6xZ8IOUYVhuxEAIMj8Yk4mIIp
         8/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766460166; x=1767064966;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIaw2BBgy4X6/8TUgYX4ddYdgedGRr8vnnHyY6AzWWg=;
        b=Rk2HtdBnFBj3CmWIRV7ZXgYthMY4kh2dA2DWni9YaChYQHJyYklwPs215oioxTDz3m
         3VT2yGOiOkNe8wiHvCRYt8GcQl8m1PGIYYWwI/oAzyZCtJ/m8f7EAhgFAuAWLDczuGQC
         KcR6H5Ss57Ho9hwgKv+TicSVu33viAThpoNDTEYbCuAJEXkApOXB5WbsyTzI+TM1wjPu
         h3mck25gPyYVqgnMUiyPHOrdQJZuSXwXFRJIJXCVIpo97dNfqp0vIW3S/2GzRpAuTCo+
         CEjeojwZxGY+CP8oPzuL7eqSnFj/xvFcJJmpAtz3OGcZ7bHoeb1u9wr6uFYexN7kpnE+
         CjYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNS/jNKLFGHz/n4NmSO8YkwaBH+n06vi65GXi5ipfT2yaFQnckLHIm7cbtYu7tMNsoJMsHE48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWScOdEtpvB2Ygrov2KqC6KgC2PiPAjA7lnYMzj7j1xgu4+u2
	7BjUf5fuSJoPWU+72ojel6LS2T1ER08ogG6B3GQy+AjZS6XhGxrD5/dy
X-Gm-Gg: AY/fxX55t47se+t+Z5Xl9kG3gwICphogJaFOI+9rJJ4BH66AY8HvSCyy3uzM5IZdSaj
	6kOb6MH6HSI+NsvxxMT8Th/b5oG+mUSMIYCSUW4HAs3YeBOxdODNnbymtcwZyd1PesVGe7pHaKD
	WST271G+2UnMepc2SSyyDpP5eSsOZJuOBX9Kng87A9khCtvFuXnzPwZqFdfBsb2qx5GifEuyCmu
	Pyf9gGlnjqH6BBVGZp7Rr8u2ta9nUVbchLQRpUXabT5HmfNlj+bwrThItC4zpUoRwQNrbF6eyYV
	kghCWVhkOuGEjV5SSAkKkJxQXlKEU9DdPgafvXA1yt5+nVLeEPJXmjp6r1QBZ0tks8AJyPx3H2e
	Jrf9BZUFFaSJn+ckjleJnlxWl3T5vavbxNwl061SUXm5FUpAJAnZ3VDC7tk9YvET0pbkV7jvKMo
	GHJ//+H/6j7VGPR2xqdg==
X-Google-Smtp-Source: AGHT+IGyFG9HgVkid7kCIt03WV3OP+yzvzYv8vgTEUV5lnnwd8VTxqHvW5riW9AUU8KdGUm/0KVsJA==
X-Received: by 2002:a05:6a20:7291:b0:35d:d477:a7ea with SMTP id adf61e73a8af0-376a7af69f6mr12887207637.19.1766460166103;
        Mon, 22 Dec 2025 19:22:46 -0800 (PST)
Received: from smtpclient.apple ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a13f95sm10355774a12.9.2025.12.22.19.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 19:22:45 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [RFC PATCH bpf 1/2] bpf: Fix memory access tags in helper
 prototypes
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <CAMB2axPcJ=U69xyyyY_7og8OALRCbOgeppQv416k9yvMiD9CvQ@mail.gmail.com>
Date: Tue, 23 Dec 2025 11:22:26 +0800
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>,
 Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Shuran Liu <electronlsr@gmail.com>,
 Peili Gao <gplhust955@gmail.com>,
 Haoran Ni <haoran.ni.cs@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <0C2A0E4A-F35B-4247-B0C4-42C52C6786B7@gmail.com>
References: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com>
 <20251220-helper_proto-v1-1-2206e0d9422d@gmail.com>
 <CAMB2axPcJ=U69xyyyY_7og8OALRCbOgeppQv416k9yvMiD9CvQ@mail.gmail.com>
To: Amery Hung <ameryhung@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)


> On Dec 23, 2025, at 03:29, Amery Hung <ameryhung@gmail.com> wrote:
> 
> I did a quick search and there is one helper slipping. We should also
> annotate arg1_type of bpf_kallsyms_lookup_name with MEM_RDONLY.


Good catch, thanks! I will address this once we reach a conclusion
on the ARG_PTR_TO_MEM semantics.

Thanks,
Zesen Liu

