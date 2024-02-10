Return-Path: <netdev+bounces-70760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF158504BA
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 15:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D7D28178F
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0B65B5D8;
	Sat, 10 Feb 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RD8tXTsO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45FC5B5CD
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707575644; cv=none; b=Eqo+i9FGNomhaXh1gFCqrvkYvLZeIO/pffa2312e0vn2hdgUrurinTASGi7RtrXvgaWgaaCWGKwT86F8F2eUnV/rBQ5DM5iEHVVBBQWBD4ECcL+zC3W+NmxjE/0aPzX72QvJj8qm31zTlFcn66CBjG1booNGS/HK64LYz7a8jLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707575644; c=relaxed/simple;
	bh=JrxDib52UG/Eb8nWQCU2M2fdjl6LJobAMyy2htoutmc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQfxkkllfadzG4xCazYIxO87zMQ8X9ZoxJsuTYpgKiIf4zx6I4WoYk70J/YWwtQh4qulvTIfPtpVJXNnwc8lyNQ/4zoy2qX9GOUzwLnSLCbFzbHqumVFoCmFqq4keP86vWNptYh9zXIJb7O0s6pGyRSnqDKNN+6S7F6MqYVD4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RD8tXTsO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707575641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JrxDib52UG/Eb8nWQCU2M2fdjl6LJobAMyy2htoutmc=;
	b=RD8tXTsOI2JwOEXDiZXuobYIv9L5S/nVdna/fDafUdvapmAH2ChlbsYSC7kVAgs/K+x517
	+2Wi9BA9RjEEoYZKMF/dQE6uWCIzWYLU1rR3JMW85UPgdQI65ci9Un+beIG6fmhaRSDo06
	BV5+7VU0tC7jxjzKGNLN19m+eesM3Wk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-Mxiv4lG2N0ehQKN9cKqzUg-1; Sat, 10 Feb 2024 09:33:59 -0500
X-MC-Unique: Mxiv4lG2N0ehQKN9cKqzUg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-561601cca8eso276384a12.3
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 06:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707575638; x=1708180438;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrxDib52UG/Eb8nWQCU2M2fdjl6LJobAMyy2htoutmc=;
        b=NTuAuiX3nSYpusHN68cngfPx8X+F9SCPUMggvXdVk2Gm9aTPk45/953VNnVeKrm3Wv
         8FADcj90YFZpPzvzP899JFekNyhkx/+HZ90+rVOT1ToGT6bd5fnO9pDOkgfLtjyX1kej
         ePDrMi8DkdoMSpWYA/7azGcvlP0cawaAuLTD8sCHEv1LFxpRyb8eh8f3+DOGLi8NlEhI
         PeGAF7V2pqerz9hNOXeyesbP3vAFbkcwfueUXU4Cik5BuRnqNfdqLKrWVeYEV/J3f1p+
         qntYLyIdQr+UiVqHjasdZBaFSb+jR7KlzttYe0M4BIaqvLn8NGflMer0HGMj0hHY7VxJ
         SFlA==
X-Gm-Message-State: AOJu0YzSASItz1ychdDcYC441R/VOC/G4zA6otaa0VjRXo+oh6sxwSVL
	gaIha941DRkIFqL0tumRu1iUGrsWDcXhcAYYbcwNSvLrwegFHuABULsXRaJgGgbFIV0lvLO6OyN
	UL9ES0fbANii9PVelXbLCe8E6jeiWKDpYdzfqXG+uzp21efVLJKLikmTsSb984blJMmEDjQlM8d
	ClkiYwLaOCRrwrGwprNx9VSLvA2uA9
X-Received: by 2002:aa7:c457:0:b0:561:55d1:371a with SMTP id n23-20020aa7c457000000b0056155d1371amr1139988edr.41.1707575638716;
        Sat, 10 Feb 2024 06:33:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMzEa0bLcFMd2O3IO1pyXYCkJt2PEVRcgC5pq7ur/ODwsmTrg25woeMT7rR51EX2mTT7OxAjYJDc/4zWiRwz0=
X-Received: by 2002:aa7:c457:0:b0:561:55d1:371a with SMTP id
 n23-20020aa7c457000000b0056155d1371amr1139962edr.41.1707575638206; Sat, 10
 Feb 2024 06:33:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Feb 2024 06:33:56 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-10-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-10-jhs@mojatatu.com>
Date: Sat, 10 Feb 2024 06:33:56 -0800
Message-ID: <CALnP8ZYvrZZW7arqEs1geyt=peukjBB-EHi+VL0qKD=zWOj0VA@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 09/15] p4tc: add template action create,
 update, delete, get, flush and dump
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:55PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


