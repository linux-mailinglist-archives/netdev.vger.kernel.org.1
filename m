Return-Path: <netdev+bounces-233809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A947C18CC7
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB19B1B24265
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5C930FF10;
	Wed, 29 Oct 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR1w2pes"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9D2F60A1
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724357; cv=none; b=bps9hacMeOWA7hgZIDu/zALixsEHLErV2AaZ9yLKlKkg90c6PRzMWNz4ole0ROiO6XHtwaRZG0NVasr0U0EHzyRinKwu5gH46ijD4c/XnkrDY/2nmmA/yyTZh+vR9449oCZYG+EAA3/riJEr1QSM7F9Sj2mvZQXxu4V/O4tcNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724357; c=relaxed/simple;
	bh=d+3F8ifPRHXFbWiCU0mXGYHLj7wBVR6XNBd6P3QTX1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjlR+v6fcFQXNtmtR1qDr8zYNRrq5gbMq5IUfu4RupS4keNVV8SO5so0pwiVHytm9h8NvT7zBVDWb7yYOshlEXDhOjN0cQhyJiGLoKQK3Ihj6uQKvWAFfRvh3JHuPpH1IV5UwYyNmDvdu3P76wX906TTcY9vlGU5OIwuJ25q98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR1w2pes; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so1306628966b.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761724354; x=1762329154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkFkfoX1+/bTv24rgjMgjWItS99qE5Oq3y2IeAjCaqE=;
        b=KR1w2pesO82Pos8i6pVakPIU2Ju7r+z/lQWWaNwG3VE1qXU+DlQjKvSevc7krHnlB2
         Z6Y8pM0EjcVcuYLttLENggrIYO+50ULTHbX/fBh0zvmVIdhbs+BRq0foCqIzwAg/hk/C
         vMR6lYkATzJD6WMxgUXtPSXrweyKTDtzj/E3/kAS5OL9ORjCnVSW4Za94+FESuKtiILG
         dD9QnX8VQDJSL/j15xbyIw62HH5kWs1NLUk0jxyUtMdAR33G/iZe8YrXBcERUs2pDtWT
         CuBraA6gRrDIyeoprzOXcGqDXuTtj0pHU58AeesgJE7gGIhOb743FxAsXh4VuqIcy9Vh
         hX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724354; x=1762329154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkFkfoX1+/bTv24rgjMgjWItS99qE5Oq3y2IeAjCaqE=;
        b=S7CkxlsC8CYDWvw9cD1HxOqraECOrd0GrEHCjJKyN9bJ1fbWDv53oS8WeB0OmCxMiE
         2XgLsq4rav1Rpxobt9af9gbDa3YNTJE7BdCnF+SEhyYwrtf1EMo3cL8DCCbglOxvrVEm
         llDSqnnDBIt8lSSXED7/UN7IwpZ9BNAC9CRJKPScQ5O04LJ2q3DnM9MC0l/OS2nt+2Gy
         gdeFHOvF+Dmh83+5cGO9YS3s7iMFfzLMPl3Y4jNR3Bbtyq9lIjbrq1SZsRYvPSTI34iA
         sYFTkeXe5Y6RDshT2ZCOvoDVTTK8hHRkW7OkgKOxtP4EjoSDXEPznteQyX+0a5rzjJjm
         LyUg==
X-Forwarded-Encrypted: i=1; AJvYcCUdB5Arkpde0blAA/tRHjCJOpH2zHem/LOxWHf95cGpURW5LrIFCLK0pK3S6dtuGDA6t/AgwoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1njqVlpdzBddKsflDX5D2JLS3o4zuxihSMRzbqJyjWKBczRKg
	oZYd4faZD00pF8E/YPl5NyJ0QeBk25F0ncQ0VnmSjJKb/JBvRgLKLAWL
X-Gm-Gg: ASbGncsZrccTeK3Ju80EcYfdDNujT3Yr+n+QCbjZRxYj4HGFnr8jtMiesiW/RAyAqMZ
	sKoPuo2IuhjNiCzEo302Bh0VG++JmGR1xkuguUCG+45BCO+61/4vifl88hsR9O2TkBGaNI6TBeg
	hitfvm+3c9CmSlFDmfos8C3KNxVBHMyfB6+OY23gqzN+1Czd6/AymkBaug6bcNTH7SutCjc4Tia
	Bk09ajWYCWjB6S7IKNoLn2UAm54CyjAjopYUvvo2KJbs1COm3S9Yzcixvw7SvJ7CRsfznX+ERte
	l6KckEpkoUDD23WpzsEVNxqyWh9aPevijEiT/rQSwTUyrhmWJT6Pu24UlPROUSAKf/0wK8PSc0A
	PIYaV7Fs+aOYvE2WEIf4Y+CWxmaOBdtyUqmK1uboOUCw1qSugXbClaKdTkfdCHTylduFmSrL2yP
	+N
X-Google-Smtp-Source: AGHT+IHtSgmrBsC3MRR28mflYTkgpLevXtnHQXIDSUigDzjREnxXOwaBD8WEsWGS3KPcLidmHJbHaA==
X-Received: by 2002:a17:907:971f:b0:b5b:2c82:7dc6 with SMTP id a640c23a62f3a-b703d4f7df3mr180499066b.40.1761724353666;
        Wed, 29 Oct 2025 00:52:33 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d85445d48sm1331864766b.65.2025.10.29.00.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 00:52:33 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	jack@suse.cz,
	jannh@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@yhndnzj.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH v3 17/70] nstree: add listns()
Date: Wed, 29 Oct 2025 10:52:26 +0300
Message-ID: <20251029075226.2330625-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> 2. Incomplete - misses inactive namespaces that aren't attached to any
>    running process but are kept alive by file descriptors, bind mounts,
>    or parent namespace references

I don't like word "inactive" here. As well as I understand, it is used in
a sense, which is different from later:

> (3) Visibility:
>     - Only "active" namespaces are listed

-- 
Askar Safin

