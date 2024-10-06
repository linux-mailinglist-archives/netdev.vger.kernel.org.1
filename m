Return-Path: <netdev+bounces-132549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A61992198
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2490AB21014
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A2518BB91;
	Sun,  6 Oct 2024 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="t7/yjBiu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4618A6BD
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728249310; cv=none; b=nJOsBO7AAPPDe+Y6WoufGt1DXxiYBigaJFnbVayMkaBgjTU16L0EYVAt306G3uwUv1wvEd4ancpiPRJNri5ZZR6mBqOZ6dH9e+z+W693US/duNyhe8a+byPVjSPFNzy7frrYZTQbSQ/FIw4kpcf9taDm/P17KQWvm/EVcVtBiws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728249310; c=relaxed/simple;
	bh=olXVaDRc9sKDu1AHJMByKbhJ+ny2cgvTV8X/DLIB2Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoPtX656P22m9/NJZsm33qL4bWvrQ3zYXfJ/n2Pq/UDuTryjNEOoShF56pRJSWim4//Wd0BytyV7kIM/ZaWygFBeU3sSc2JqzEvrYXgR+LyGlsHYOwtQUJbYT6JWVfNRGfv32cGLYyke4l6ITZ5OSzdBGnwh/RULuU0SVAlOH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=t7/yjBiu; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e28bd4e70cfso605262276.1
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728249307; x=1728854107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6BpBixglTcARBO7wAvcoT3IQ3RW81geceCKSOyrBJE=;
        b=t7/yjBiubx4fcTrKVMeie+wsrrtAH/O9XrEkmHDr+l2T2YWPUJ2t4CV6/yo65o40ps
         Tpi5ecUD5/nkrehfQvu5IymMa7E/xkamV4JV7GG4ScDopJyTBBq7FJuM8lr1oD5uyMBi
         ++mt23nZpjUc0y/SsGviyM01im3XiLiJ16Yfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728249307; x=1728854107;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6BpBixglTcARBO7wAvcoT3IQ3RW81geceCKSOyrBJE=;
        b=fKxvmfPeQ0VwkHbYs1vJ2/P61Z5yqm/ikUouCuYchPZKJGNgH5Clm6GLJLwcynY90J
         N+SVZIgJvB0PL3C6NGFcNUDOiOtwYCGu+NxgaExi108UbxhPmEmss15CK5pvPyfBjEfl
         e99G01WtRwPRXUaxeEsox0TL10S+1cT9pKaCQKA0ZVBUwHK7inqji0+KlIBKlWfHsjgg
         ++SWy41gANVS9Uj7ggLYp0d9ksUuUMc0FWT4elYgpCW40YqNYjPeaBy+D777yUplNDPY
         MdEmvE6Za/8lX7jJ1Zz/Q56zI4poEUq1RPTEiTe9QJhXDyPbA/PK0Qv4tKxm2ofFDL8u
         2law==
X-Gm-Message-State: AOJu0YyFa2YxfmPKxGW5WRLvWrGiJ0Qsl2PA6mOfG5mh7rlw1EUNbcxF
	hOLzNPU7+6KVWSHfPaDHtnHa1tXJnMe1pTuSPUWHvB85cp7MDiYCUizLsNt8XnP1WgJfmRU213v
	5uUrIQTnu2mNNO40jEzHS0PolB1WHNyTgM2nxv+Zml+jxICi8sJc1YXpKaWGww4hRqIeluOgT2F
	EJ+KaARcpzpubgqWSptwRkILzbswyvuX1RbuY=
X-Google-Smtp-Source: AGHT+IHSNEBMZ8pwaFq0A8lXnAil71lx6mGkLqiLShB/xAcWY2MPUF5Fh34gf3bdCBLWBtDfnXNHDw==
X-Received: by 2002:a05:6902:2382:b0:e25:ce5f:42cc with SMTP id 3f1490d57ef6-e28937eebfdmr7612253276.32.1728249307153;
        Sun, 06 Oct 2024 14:15:07 -0700 (PDT)
Received: from LQ3V64L9R2 ([50.222.228.166])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a593b3acsm692395276.2.2024.10.06.14.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 14:15:06 -0700 (PDT)
Date: Sun, 6 Oct 2024 17:15:04 -0400
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Michael Chan <mchan@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [RFC net-next v2 0/2] tg3: Link IRQs, NAPIs, and queues
Message-ID: <ZwL92CHG9YlNKto9@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Michael Chan <mchan@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
References: <20241005145717.302575-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005145717.302575-1-jdamato@fastly.com>

On Sat, Oct 05, 2024 at 02:57:15PM +0000, Joe Damato wrote:
> Greetings:
> 
> This RFC v3 follows from a previous RFC [1] submission which I noticed
> had an issue in patch 2.

Apologies; looks like I botched the subject lines on this series
somehow.

This should be RFC v3.

