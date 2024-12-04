Return-Path: <netdev+bounces-148747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BDF9E30B9
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01689B23215
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 01:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FFD79F5;
	Wed,  4 Dec 2024 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OssZ8Eqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C20523A
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733275414; cv=none; b=dnfHE7k8CW+iz9EpVYOTuCeMmmNxlAkpKx4hrN4PYqzv4rJSLu6r51f0UcNrHy/ZljEMOrDBTJDUThfks+NrGkZPmgOE5CiOsyK66sDkFx5irMXXKQnEP1/md1gFdhmcCngZSfK0bmQq4d8nI1IFfc2EN2VzDYUnTj6lmiFkOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733275414; c=relaxed/simple;
	bh=+7qu2OdkMDrWyEA/AbNp/Eldt4Pq/+jBPwLnQKSEnQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5Imnc2g0dSG97QBroi0PfzCHgz1R1tPwGQ7kNUNnamnEYv7kywS9COwotJbEP0FmxOu3m6hJr43UIK6GwUAnyjFciAuIRhDnohiJcIVHVEx48tqbfyZftxhEKXqXnRgo2QnrxWKMgkKdycJ39L+io9ZTx8Tq4Q6+1dER6/3C7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OssZ8Eqr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-215740b7fb8so37645ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 17:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733275413; x=1733880213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+7qu2OdkMDrWyEA/AbNp/Eldt4Pq/+jBPwLnQKSEnQk=;
        b=OssZ8EqrNvOyNMZVXB8a0DK/P1EsUCSmrDWW+TJqqBj7w7N1NVMTT4o6ZjqpDW0+yh
         XZa+h6L/R6dOUjR1eRz/RiPuXuvBmf3rdNOe0tEUF9jM032goRChfZoBEJIs4K33AJ4d
         lUcdx7UWPtCUiUWWCJ+mQ+biWnFUAZnJfUzlNncuDo8DqaZA/7/B7TQ8i1io+yzuABQV
         NuFtE6YCfDWdwUs4nbf82yNCZppfL+s0hi4pgYKDHhT+Rf5J9aRvmWNGdSNZQk7dYDB5
         MooYUt4He+4MxEs+BEU/2vjTd6FqJC/lgxp4DtBRG4LL6Del0GgNvb0dwRSbi7bP60N9
         chOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733275413; x=1733880213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7qu2OdkMDrWyEA/AbNp/Eldt4Pq/+jBPwLnQKSEnQk=;
        b=nc0kR1HHB9bGDPsjls/oRxOd/v2n5bODhfcNW5RsxuvwHb/zYuRM+agza+qWGA0aMn
         GnrqL4YkrAGHFLDNxIL4QbN159Knx2wcAwWk0Z8KrYdiSrg/2c/ZmlglYPzjYD/MYQqu
         ca7LhUkjpZaqES+AAAPbP9aMHaIXFa//WKo/cnL1P5yduBA3asl7ttW6tqeVCb01x7ht
         Gt9zPK993B/NsOQTeJR5LQnBH5bqDJt6lv/3mHO+AyPGG5lFiNF6Z1ReHxW9i05jTUZD
         cPbY9YTF9K3U8Vaqki6wuyyo5ZJj5sjECIjZXiRqztdrwnj8JzGkFt75gx6UE5xQzzi5
         Ex0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsztM+KLQcG5SA/qYV8kKc3Kjjsi9gw4fRSpLln7Y8uxZPyvHFl3/8S3qPD2LnYcwpYIm8iuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUFZMv5CvPBLecRNgkIbNBYDEVlU5Cw6UKaKd83gV0NoTXibId
	GwLocz9dsVMwWuilL7l3cx9KH+Ok5b5SAhSnCjZ1NTDhqq1qsqnbyNu6Twmn33y7J7rA6j2LbZ+
	KOSRlgbirRUYj5xgM1FyjVAuhiB0mkGr6hOVA
X-Gm-Gg: ASbGncuzNst6vdCLPyZS/uy8tFEyFajtjuUIS2c6xJVD1Re4m0qPf+znBPVsLzZwhyj
	GtyDHFdMAJRhzV1dTDYZG1r7qZjNyH9unN/0NBdMN9wABVlr90vjbrVECQRccjA==
X-Google-Smtp-Source: AGHT+IGD28NPEj4py7ZE6t7UOPJEzjj4CwV1nKf1e4xWMi3ISwCNz9WuJpdVSU42ZLi15gw0WaF/NMUP2mbpoyKo0J0=
X-Received: by 2002:a17:903:2a83:b0:20c:e262:2570 with SMTP id
 d9443c01a7336-215d6c3ec59mr1174565ad.8.1733275412322; Tue, 03 Dec 2024
 17:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnTThMBDKCXufNaeci5uCeddOgLvXmqszyJoT6N=6xtWug@mail.gmail.com>
 <20241127232133.3928793-1-jrife@google.com> <20241130095624.1c34a12c@kernel.org>
In-Reply-To: <20241130095624.1c34a12c@kernel.org>
From: Jordan Rife <jrife@google.com>
Date: Tue, 3 Dec 2024 17:23:20 -0800
Message-ID: <CADKFtnQTWLyTej3cf+SJMWHNMPvZetfW9pUMH0K-tBOGxXLZRA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

> Better still use NLA_POLICY_MASK() so that nla_parse_nested() can
> perform the validation and attach a machine readable info about
> the failure.

This is definitely cleaner for the new WGALLOWEDIP_A_FLAGS parameter.
Thanks for the suggestion.

Applying this to WGPEER_A_FLAGS would simplify the existing validation
logic as well, although I think it changes the error code returned if
a user provides an invalid flag from EOPNOTSUPP to EINVAL. I'm not
sure if there's anything relying on this behavior. I'll let Jason make
the final call there.

-Jordan

