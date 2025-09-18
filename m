Return-Path: <netdev+bounces-224219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54679B826FB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 02:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AD11C248A8
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E73E1E1A17;
	Thu, 18 Sep 2025 00:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzGvJlF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8336D1DF748
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156378; cv=none; b=o5E/bxmplgGxYRrqDYlYSZGJWpUvx2xfz3a4zwRwRjGXOcGKI48VikdN2ZfbzRBFr2Tved4qbkfGdAXYHLhGP63NICLNphZjRnccH2RFvMkZKTNcCPJlU2urzG1CzwHc9c004IURltqRF/mAyUUWdMf/5bGCCMwQLHMYktdKTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156378; c=relaxed/simple;
	bh=UIo7RA/G/xDD02JBTiyBlQlJJd9IfyisvvvnbSKMNJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grCnLt8nKCotH9VNFhkVqvbE5oWwy/FQi08dlaTLUecIRnflIezQPfjMVAw8FK3bCTB00+Y3ihjsl8VI+msY0wMo/opN4J1ZrR298kamuVu/SLY18hJe1Wso3nuFYvZ4QSQDd8cXzRsCTBlf2ty33o5J+J0fzCutDQ92F+dsZZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzGvJlF3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0787fa12e2so61758466b.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758156375; x=1758761175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=KzGvJlF3KPV470aj9p2+WGc+dHQyYumQ/n1JBBocmuZJA49YLeiUqmwy+/yYPZgQZj
         ssXCb7z6YgYiOutrT3AfsrRikN0B83+7ruvziWNhCwsz2ELTIiizmfls7PvsFdkvcJLT
         qpJdXp6xZhBTLS5nekg+F1LDSdhm19EysHMtk07fabj1P6oLuOyCMfvOGen6jT1eBwbP
         6pMnjF6KJT+0XEj91pCTwQujjt7F6ghOtnCnJ+EU2+tXugoJTsFgk+QsjwfhKOKRRjgu
         d9FePQZs61kpvgUTD0qeflLnFiVK5p7eAvAv3yf1sOrJiE6TsrG+zJ2UIlYBCl4PmRtc
         hKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758156375; x=1758761175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=qMx/7lIRib48Y7q+qscE9mmQi7INmgvrpMPjx5jkC8kSGsnoerV2x3xk+LB2VUnRIT
         N79FkdRNlAk9VqIbXpZ0wPsUyevaISKRRuxuElWIQ1N8o4wMLUBklLnsIO1CWu8ubryp
         F7TJTyWv+I2b7v0w8HZmbGMkgBiA99zQlNNU9g0quhRWJJQNapDyaj0lL/fjpogSmxEL
         w8uFH8JXDykXLcY7DNfIkJEqlp1XcmUYHRUD6yFE+aCzDKJ7l2tpoMDjDdp3yaJ0ACOd
         94l3VTRtpFzcWFuX9gSwtACTb4ql8Adi+QfmvV6b5RFxevB26w8GqEs3Qcr+qc9YlaAh
         /S7w==
X-Forwarded-Encrypted: i=1; AJvYcCVG3AHHLSziXV4+3RCuvYVregFsXkkNNTyVYHEj3339qd4kBhirOABav8DxaLs/SuVFQQhcXok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRnPl0ho7wUrl4Awbuda6eo+mKxSWuK+qmnip/szu7g701SwLS
	aEfal3jI2Ay0MqMd0YTM7vzqZdm9HoTq+a4Z1P0GKNoOx3o1C43bKhHB
X-Gm-Gg: ASbGncu6U79RObt1e1tiYSZQ1IW+eYWmgg0znL6Mg5s+DJ1WyeyIzdB1zSJUzAGqb95
	xsxkoinVKB/gKOB5wspiYdqXol0FvvqYQ+J4NgbWMJyAJLkgIhG/4/rCpfCA3R4DuIExQHnuy+Z
	D3zAsY/gfCD0EqlxBN8EctGjNGW8T9FMQaXOFrOnYvO1HjXzlETFf9FsRveqScFMiQTiDHqkPng
	8UCL1q+VpiwluML3kRBmUrLjoTQd2KizF/G+ALsM7/p/yVr/squV51vXzMMkUtZCxSQLCkeK4uc
	/crEZFdk7jdVtUhY3Qz6y5B1CvK8J34aXlUh7QJfrbbXQN/T7ufKqtbttMHROQg8oMlCm9Dn46E
	aN4N+QiUOejrtaJIogtOIa8YXxWbq89whmb1Qhg==
X-Google-Smtp-Source: AGHT+IGtolM3WpmMOfPkC5aQN2+QGXojyD9zctBgGDhejOP10KXv+fVObxP+zNTcUHL0l2vGVmYa+w==
X-Received: by 2002:a17:907:7291:b0:b07:c28f:19c8 with SMTP id a640c23a62f3a-b1bb7d419c3mr514517266b.30.1758156374473;
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd271ead3sm73266366b.101.2025.09.17.17.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	axboe@kernel.dk,
	cgroups@vger.kernel.org,
	chuck.lever@oracle.com,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	horms@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	me@yhndnzj.com,
	mkoutny@suse.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH 17/32] mnt: support iterator
Date: Thu, 18 Sep 2025 03:46:06 +0300
Message-ID: <20250918004606.1081264-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move the mount namespace to the generic iterator.
> This allows us to drop a bunch of members from struct mnt_namespace.
>                                                                       t
> Signed-off-by: Christian Brauner <brauner@kernel.org>

There is weird "t" here floating at the right

-- 
Askar Safin

