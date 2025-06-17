Return-Path: <netdev+bounces-198586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9E4ADCC5E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7EA3A7C79
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87AF2DE1FF;
	Tue, 17 Jun 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaxosiJk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5C2EAD00;
	Tue, 17 Jun 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165213; cv=none; b=La3S+1wM9yIRpingi8aR6Ld64VUvwc90ScG8iRNatO+JDiakp15xiM5ouH5PGwSDGN2otTEBW9uxGCZ7kBa5oRJmv4sxWLMdM+RkPb1fh82U5Axp6JLyzdiiwC4WSyz/NNY+vn/fu/jlshtXtyDtRu819Bw//TvF7J9D6vEEl5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165213; c=relaxed/simple;
	bh=Tn6DIXlUhv3B7Mxsw2Vcugb8YFMBuoDehiPuJhnVEK0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=pEkX13F8DqoUwlbSGGHZB2R7J2qkJpAC9jiCMjRc1AQ/QVd7XuL5jbahRYHDn033WTwtDDQCvD1ceU7Ox9MWemTqFVzdxWMvdsdVZsufBU7RvHob4TL2P1U7RQ195uXjx5ClehXHGUqvmCKh8LEIu3grKz5I3Dy+bUMSkz45Ro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaxosiJk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a53359dea5so3931209f8f.0;
        Tue, 17 Jun 2025 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165207; x=1750770007; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tn6DIXlUhv3B7Mxsw2Vcugb8YFMBuoDehiPuJhnVEK0=;
        b=HaxosiJkRHkujeQUAjWuX70w3wQGSUR7ntvsE+8T8wUNbxZ4eKV2kIMZoICRiWqss5
         4RBoXuuocqYXMD7eWZ2fmhGjta6PcP/TauG4VT2OE3Ff3/2urvhk7dd9Z6DOsrGw2IPb
         xuxOGzNcK1tUuTsJwiksKdj1/fRdZSNrWkyKkz5WLyNJTYypPbpTBmJPO47nlTb7iiMz
         Jl3XvL364TPbiwa/Gw3Z6Ck6lzI9Hvv86eGshYnFoAN4SOkoe7EyI4P3m3EXMEBsQBRD
         PXx3giuOZlhhfoOTHJy4uat0Mvv/kfFAA42nh19bBsabpiJEyj764C7qpoWFmc8oZvmp
         UOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165207; x=1750770007;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn6DIXlUhv3B7Mxsw2Vcugb8YFMBuoDehiPuJhnVEK0=;
        b=RwSMDo786stUsZwoHGq9rQ+UGPXlvex5iR7wtXavs5rxXL6Cc9f4wrm6EURV4dwSUS
         pKKXFHpvSEeNi1HNvScB5Ps8iVxjX5YDLIREI5D+gD4aowB4M0IeA2/Y4Z9qgZ3ujzyc
         B1hEKPndynmvT1i8+VuhjBgTpx77hgtfAUeIb6NScDO06KQR22datLfJZBMXSOqYxRIB
         bHmLFKARhGT6Hjpxj9cJKntX9NnplcBo2tNEfUVH/BpovbwpUIn2rLLx1LI+w9M52ACv
         Aq7VzmLLlUiN8LV+hcVhs3jaBnYfo57tCauP+ElfoGj1fLE8iW++aa0NA7mfKdU26/bx
         iNRw==
X-Forwarded-Encrypted: i=1; AJvYcCVeptDj/OwnTXMBjMBKo5HkwvsZfPV+PIaXEdc8PidPYza8BUY+UnbnglQ42SthAgXAW+C2YOKz@vger.kernel.org, AJvYcCX5pHCNIxjYhoUoNhnZOv5Phm2vbCSSOmVHmfnMExlZe/r/sRhlZA/aBhTidEzhiWpE6c+4asz/P2pOgJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdUAvm9GHLphOo/K38WFa5acsrVBy0f9Y62zW/aNILN5aDDyP
	sBUwOT1uvDxs6vruNnsd4sY04PPjDh+02P3sH6nBYZ1U7HsewsG80mo0
X-Gm-Gg: ASbGncsg7jCM2KBcgq+SA/o9bNIrTF/8eGJZZUvRJonfnuXQgiBuzY8YWrGmMe4Fg0w
	ABJebRDSZsSx4SNksYYzWzsSwsp/j4gVojyP/YQExDxw91gbG29+bO+f5/E1+SBWcFgTykFnZeG
	G4qJ6lgrXq8M8H7d5pscV6TWtWO+FnQFguKjQrJ7acCL4W6Y3l3gx5tHPPH2JwwDVefbVE0Aucv
	k1+EfaHs6cZWK8sTn38w/cA3sr0CKMg6Qr/bZr9rr8ylcC9m7mBFmWtKGknfGy1ftHwlouoaf5r
	KRz01xWPfe5vxzPPI3/Vk76CtSGpcx5kdHOAfwz9CtAVpKg+RHqqvqFQCq6sXPB16JNG1WyvJuU
	=
X-Google-Smtp-Source: AGHT+IFkHumuNOw5OMyit+NMq5xP3L+6hRTHFZsw1kWHH1x7SYNjE0rJe5ZLM7vSjscgPl5z/3ZYAA==
X-Received: by 2002:a05:6000:178a:b0:3a4:f72a:b19d with SMTP id ffacd0b85a97d-3a572366706mr10967411f8f.8.1750165207082;
        Tue, 17 Jun 2025 06:00:07 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8931:baa3:a9ed:4f01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a60f5asm13787720f8f.25.2025.06.17.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:00:06 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Ruben
 Wauters" <rubenru09@aol.com>,  "Shuah Khan" <skhan@linuxfoundation.org>,
  joel@joelfernandes.org,  linux-kernel-mentees@lists.linux.dev,
  linux-kernel@vger.kernel.org,  lkmm@lists.linux.dev,
  netdev@vger.kernel.org,  peterz@infradead.org,  stern@rowland.harvard.edu
Subject: Re: [PATCH v5 09/15] tools: ynl_gen_rst.py: clanup coding style
In-Reply-To: <b86d44729cc0d3adfdddc607a432f96f06aaf1be.1750146719.git.mchehab+huawei@kernel.org>
Date: Tue, 17 Jun 2025 12:12:28 +0100
Message-ID: <m2bjqmk4f7.fsf@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
	<b86d44729cc0d3adfdddc607a432f96f06aaf1be.1750146719.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Cleanup some coding style issues pointed by pylint and flake8.
>
> No functional changes.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

nit: typo in the subject line: clanup -> cleanup

