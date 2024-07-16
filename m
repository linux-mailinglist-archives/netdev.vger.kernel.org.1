Return-Path: <netdev+bounces-111704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D916932243
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 967CBB20BB0
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE55A17D36C;
	Tue, 16 Jul 2024 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PUJ9oacj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C9941A8E
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120099; cv=none; b=IaWQriHTH2H4AqoLvPgErOJ18AXKFGNSAPQASvENrqm+uBzTAweudeb9b2TfpszvggeZ7Bnb107CBcQQGZUCu71yudMoqhuQ4jONCEDbJo/rZwGdbwztFhdHuoa7f4g1uIF9ua/mbRKgN/QOpv0Sp+SnCSv/YMJ3t00aOVaH4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120099; c=relaxed/simple;
	bh=SJen/1QT5j9lBSLAkF5vcsbT2VObhXZGBhF55aYD4dA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IWLj0Jo4VTSAOVvm/Cjd8OnXP0GtbTPniMirnIhEikhFvwpUBl1df3fqjObbaV0GJdr2S/Ayl56RFLmQeBVd1Kopd791YTqmmOK4E50iR2OycctjbOBiTsNjVPz9RZTPyytwjA96CvqidySoptNKk/g0Eby8pZ3/Vl5PZxemE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PUJ9oacj; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58b966b41fbso6582712a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721120096; x=1721724896; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJen/1QT5j9lBSLAkF5vcsbT2VObhXZGBhF55aYD4dA=;
        b=PUJ9oacjkJTrKs/+0gGAmB99AJwLGtXY7gl0Vp8YpiFY3VwBnj4p1M6ojKDuN3EX1T
         1VjE3SvGzWvZ4m+oRav+eI+kDOLnJ6x0uOhibsogXZYku6dhav8EHJhNFPUMBOOfpMYN
         j+QK55ddOJVPEIOY7qAm0t0XJEU1KhWdUt0CHPm1UVbLShTu5ReoaqyTrRgJonRVabqU
         rEkehN0tZDYkFgRKCKvtpkTalZyRe4eV83qP7IMUW7Juvrsior1B+eK48YvhjfTGMPHP
         W7Xf+DXHinsmKnrsuhlK4PCsDxFLL15vOo0a33/PYyK39mycdJ+2ZG4SBVsUB059krlk
         x8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721120096; x=1721724896;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJen/1QT5j9lBSLAkF5vcsbT2VObhXZGBhF55aYD4dA=;
        b=sx1t2q3RTBwoLGezRI6RP6sFL+9oKeTIsHymcA0WgyiSR5SdTf5vydCZ3ctODc7d6U
         G87tSNVaTlBDM8AWo/mAXK0c7QolKcwAygJVwnrk+uykghmKmxFBnVK/e3agFDwRC7MR
         wSyz03MG4ipRzolQ5oxnAGvp2vKNU/giz4VK6jBN173DpWkQKmYIfyL3qrKoRE4JFVnZ
         F0v/fO6leaRPKdDHwndkcJG+eaB8yHr5R4RfDi69uXk/7AmV46zb+HIPK4wUrT17kjyQ
         tseuh56QJbjOUgt9VEqfcilIygDEBjllZToqdpvCbs8YuEhzQM2YVQyj5l0N8UiT6Spn
         2CNQ==
X-Gm-Message-State: AOJu0YzDYrjoJ3jTsxGoKgkDtz65kzabZ4HZ/eHAQrFl4NcCSRmGsfEX
	4XEqT/gVq7TYRYTadRXdulTEAGLo7GczaXHhH5GpJA1jbf7rMrle69LLtgllqKk=
X-Google-Smtp-Source: AGHT+IHEX3XLbWwFTmlBuVFSbqHwHwV/VNG7yL5ANvbtlfCyppiI9BxcfUOkzXt2VUfh+FC0HMhcjw==
X-Received: by 2002:a50:9b55:0:b0:57c:4875:10a9 with SMTP id 4fb4d7f45d1cf-59eef66c611mr766098a12.24.1721120096477;
        Tue, 16 Jul 2024 01:54:56 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a2705sm4495027a12.60.2024.07.16.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 01:54:55 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v4 0/4] af_unix: MSG_OOB handling fix & selftest
In-Reply-To: <cc71d3c5-41f9-4e6a-98d2-7822877b6214@rbox.co> (Michal Luczaj's
	message of "Sat, 13 Jul 2024 22:14:16 +0200")
References: <20240713200218.2140950-1-mhal@rbox.co>
	<cc71d3c5-41f9-4e6a-98d2-7822877b6214@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 16 Jul 2024 10:54:54 +0200
Message-ID: <87jzhl90o1.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 13, 2024 at 10:14 PM +02, Michal Luczaj wrote:
> Arrgh, forgot the changelog:

Take a look at b4 for managing patch set the cover letter and changelog:

https://b4.docs.kernel.org/en/latest/

