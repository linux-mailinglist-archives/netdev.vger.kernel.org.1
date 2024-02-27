Return-Path: <netdev+bounces-75296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B130B8690AD
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFA82828CB
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76C11EA7A;
	Tue, 27 Feb 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uObex2rW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC101B28D
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037331; cv=none; b=Ls3x8cCucXflKQlujKcYNLf350f8NgJd40Hepw4lhAeL7eV3i+bho/gt08peeOno2yD5GjhfcFeoqlhSelsRrvs9gDIw0eZFwlIXSZt4XqDanz/YstwmqxulFyCMJZm5x/QalrHefXZ3pvIsK6XwtMhSLRduYDD+apvgSyGCLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037331; c=relaxed/simple;
	bh=LqQjNtAJzV/gp8gce32yqi56pdn76UnZ3HyAMC87ntA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy/oZ07oqldG61nRfj/qEyai5haEJPZ48LbqOMhmH4PRTS/OefaRDeeWrx1r6lmY332WKr3v2j+NkCnFNS2zhXqBtVuNHhD2Y079qtkBpCTep9PXAZ4JuE02fBo/WDWI4O6rldjoYfDjJ0FLMysJkvgSd1vF+0PRSvRtODHVQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uObex2rW; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d208be133bso65284101fa.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 04:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709037328; x=1709642128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqQjNtAJzV/gp8gce32yqi56pdn76UnZ3HyAMC87ntA=;
        b=uObex2rW201aM7ZqwwO9pCHCkJjgcAPFhwkT13/XIhNXSAHWuzgsLT8xGGpr/9hoXQ
         1olbPDn+1S/G51wV0NyeInwNDidQTYRFDXhgUDkfVg4gFP9e2EKgalJf0ZXd89coLv/R
         AgVDPvNp2qdNlNWe1MVMMrIt+APNxWG2MD/aVklw5Zr+WodZKhSdsT78XjWo3bgW8AaS
         0S8/Ia0l/iSYG6TCMiO+VPVPtbwlI+/pgOa/9T5trNSmAB0mbwc3hd/Dwg4hYrBbUUpj
         tZplOWaKLohoevIHsfENhBokSxi5g3YPOulbnpTtq0wfX5wNlJWfKiQ6l167Cjs/RRjm
         At0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709037328; x=1709642128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqQjNtAJzV/gp8gce32yqi56pdn76UnZ3HyAMC87ntA=;
        b=ISsdnWxWtZm+a/4S3g3uHtQ+gjm30WnUwSVVR8hLTF3Qd1xXJv6VuEl8ml3XMRETpj
         dwjY4oJg2kkpYIkz4uc8oqwe/obAw1MhdJzTqUaB0J7NsSh68Rox1y4ExRBW1H/xYOng
         rKLGaKc2RU5Cgmw2tyEmdGtbgooB7h/ExgQSptv9xLJaBpxfwiM/gSUgacFTyUbW4gDy
         IvXapjWeB/i666wwUrgB26o8HTw6MgrOu8rXrO9hcrAt8NVRbfCZidO//rWZHVL41ALG
         aCpf+lplN702wHYwbIMmUARe3WSWzUNsYwTBc/3mA9akkGFrSVcVt5D9WKEybPYXXw2V
         ik2A==
X-Gm-Message-State: AOJu0YyeiBn1NnI+4JdocoaA+6dQQE93FK1r50wKwXOr/feUwAbxnWz4
	4h88Mq2smQiiF66tNUEckAYEjIJqGoP4ms5T6Isg/nvYDhewORCXNcOOXExjUkA=
X-Google-Smtp-Source: AGHT+IGtVbQM40FX1l0FwsCKabOK5Fl9BQdKbcv5HV0cfoBXNg6iZRnkx6VgegUeOQlFiKpghYbRFQ==
X-Received: by 2002:a2e:9ad4:0:b0:2d2:4160:bb6e with SMTP id p20-20020a2e9ad4000000b002d24160bb6emr6176296ljj.27.1709037328163;
        Tue, 27 Feb 2024 04:35:28 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e9f52000000b002d0a98330b3sm1182269ljk.108.2024.02.27.04.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:35:27 -0800 (PST)
Date: Tue, 27 Feb 2024 13:35:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] netlabel: remove impossible return value in
 netlbl_bitmap_walk
Message-ID: <Zd3XDMRqN088oSQW@nanopsycho>
References: <20240227093604.3574241-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227093604.3574241-1-shaozhengchao@huawei.com>

Tue, Feb 27, 2024 at 10:36:04AM CET, shaozhengchao@huawei.com wrote:
>Since commit 446fda4f2682 ("[NetLabel]: CIPSOv4 engine"), *bitmap_walk
>function only returns -1. Nearly 18 years have passed, -2 scenes never
>come up, so there's no need to consider it.
>
>Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

