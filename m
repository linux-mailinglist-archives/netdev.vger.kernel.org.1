Return-Path: <netdev+bounces-222633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218D2B551FB
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F063B82D6
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05128309DDF;
	Fri, 12 Sep 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EOo58T3k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97692FE06C
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688117; cv=none; b=cXrV9h4PcmNR5sEb0fyyjwtrHW3IhT3zkehXNS76wRo8R75B7Xk9mOBTJpcYrE3mvcnylDCwIpLjwdoO4ROlX2tpd4UfPKvpDBb1Nh0/T0quy8nimCY5VOA/kNDV/s423JjL1rI/mOmYvuVPS21PsowtfAWLE6A5u+6Bfs0djCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688117; c=relaxed/simple;
	bh=FHjbJdtudyt0vGhKMApu2KHBlfl47fZMhc8fNsFkBJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNkSjZ+6A14TvNbxysQ6XrDuA6v5I08Zfpl78aeZww29lAtfpa7K2omVC2Z/LIZYbbPGJTkdVyvA7qjkgrgz4fhXokIvSuTfWrqUAoqfPGllCfpgqcDDaLnVxtUovUQc6ei+NbNqNufy31N1J4T3Fx1qMnGzCmFEmP2TwZEeBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EOo58T3k; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso2306101e87.3
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757688114; x=1758292914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHjbJdtudyt0vGhKMApu2KHBlfl47fZMhc8fNsFkBJo=;
        b=EOo58T3kd5XIpsTxxM4+JwFhsnF+OAtJIO4BQ1zsY8vM+Kshj1PyXJqnfB+v2F8IWz
         zo9Qj+imAK67ZOvFNPfjqtfiIX4YVRdxLVc3+2p5y25IEmRhfWbX5X+18hFzS976pFJd
         QKeNos/2V1YmQpZnXLz6iO3lT77QjjxAo1shKYIcqJ3bMNFHhnrm78qx/yovIdrqBnzA
         r0GhwfetXtC4ziMWKI2q76bnZvbLcR5N7oWSUnZhqjxJirgKOnkvLp9j7kocgrCyUUKz
         P55S0/nuXYjt6QOvYSiB8rfgcUaVRjWww2Z+hMy6s1BEEkA6TM3bmXiLfUb9eisMGtNe
         z91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757688114; x=1758292914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHjbJdtudyt0vGhKMApu2KHBlfl47fZMhc8fNsFkBJo=;
        b=NQjz1o6KcTHtDaPuERP7xPuHORmc49qDWQnEQFXMyMfMz3lKzVqutU/SN4aw/nMfnu
         JT2JSZYh1WBhCSR4oh1VqqfJ3hg4SWcFuOx5np7yEwwyrw4LS4gt1EQW56ZkE3xDruDs
         mevgT8L173lES2MwLFJM7Qrb5ELJzIryRWMej9AsRoQTBFNQ2Njx+FtVm9+jJcPt/M2F
         +NrYKxiWGfZWZj68WjDNezopOvVE6VKTMHKbalftrahvw+blZClDsg28yQlnVzdCQ6it
         a5IEirmOfxieanGNwRr6orZXtBh1r3ujSE3iE18TEVfhGgB6z93sR3QB1EU+OlyIAD9B
         ex3g==
X-Forwarded-Encrypted: i=1; AJvYcCVOzZafNyGd/lwE0tmPQ3fOPmUAKVNcPBYLsMVSK1b3BY0+noi5fhqvqJKxNlqNAFI6VvBcMYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFML/tvK/TBZGV4/uFDy24OBqv49ovFX5ZkxBHGdJf3ZR3UfKA
	UVmroA1uy0JOEMksIqqTjU9IIff+T90yX/fHFIgnyaiieug64Tcbg62vJizF1Mdho4DuH1Rnz7I
	nVrMy9Lkp1rLyUHbguMob+c+34VtYmkxyk6l+xlCfWA==
X-Gm-Gg: ASbGncvU16zjNI+4dJClSeZyTQlFyYOZV5fIoiJaDfZCY0NEsWYap2jdQA+ntNEcwce
	O5swpK05Rxd1CwInxGm650Gm1GV+KKfcTkgkPwzi0Z1M7zJlyP7XNzdM2S8CpETaylfe9LWaSnU
	SR/aRD0v0S1n9J2gxX2MTunP1VMDwIKWuFYOg2jRSF/bl/pmBb48EWV4uQdyHIBDu2/Emq6rAWn
	0F4Pb0SwE9jJPXhqP/7WSHfyQRCTbJJ+NoXYejF
X-Google-Smtp-Source: AGHT+IG83mg8C15DLml5L4U3tdpjf0VWv0vGOneubDXR1XMdjs97C4rBDul+MA3shLn7lg6vC3in887d/AjcxERRYDw=
X-Received: by 2002:a05:6512:3b95:b0:560:8d61:8c03 with SMTP id
 2adb3069b0e04-5704a8b5ae5mr969535e87.25.1757688114063; Fri, 12 Sep 2025
 07:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090505.104882-1-marco.crivellari@suse.com>
 <20250905090505.104882-4-marco.crivellari@suse.com> <86200ee5-c0dc-4a70-823a-ae36b2e6c544@redhat.com>
In-Reply-To: <86200ee5-c0dc-4a70-823a-ae36b2e6c544@redhat.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 12 Sep 2025 16:41:43 +0200
X-Gm-Features: Ac12FXwV1cD9lEMSZ-Wc7hO-DGas0od81NQNgf1aZIWSP1dpFq5I19w78J19LHM
Message-ID: <CAAofZF53u_AfOMbGE1d0RW8-M=VZhxCzvMSTxUbxsrhAAg-8wg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: WQ_PERCPU added to alloc_workqueue users
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> This and patch 1/3 do not apply cleanly to the net-next tree.
>
> Please rebase and repost.
>
> Also I suggest to split the wireless bit out of this series and send
> them to the relevant sub tree, to avoid later merge issue.

Hello,

Thanks Paolo, I will do as you suggested.

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

