Return-Path: <netdev+bounces-237059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF593C441EC
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 17:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B11A347045
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 16:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06183002CD;
	Sun,  9 Nov 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OubG2IeQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396F1EE033
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704437; cv=none; b=nRM15091i+KpntWmY5aoBOF9dc7GqMgN7xJ+yYZhB/rbn2M4BLeibiBJzFmbqGI8zSAOYTI4gXfzVYuxWXmFvECDD/3PZXm1jMcoi0kBGT3r9xAIaMElhZN4oShF5vhUGh0tAJecGhb6t/OzDAIPDNG32jV2X1C2iCuh6FI3xxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704437; c=relaxed/simple;
	bh=S9fgHs7LNXxCjvnR8z+jGu2x4XIB8BbhT/m8R+mBEHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5TtKEbcaBpjY/2udZVGczinpCyD3R4e3/5BrOFWEJ/mF7a7OWb4zkKGD7kG95iB5EJ+H1ISqNoTjbLohIzyrjCrEso4KJ9cc9kLhN3eS8VNoE/TcqAB31rFQ2b2lSHZdVdzBtuEGKZxJt1hWAozwQnjYPlj0XDSQUPH8Qc4cWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OubG2IeQ; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4501b097976so1199449b6e.0
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 08:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762704435; x=1763309235; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S9fgHs7LNXxCjvnR8z+jGu2x4XIB8BbhT/m8R+mBEHI=;
        b=OubG2IeQ9apOtG1a8WekuXVvEf7ERNl3jeXicoBTIntCu7pBJ0MLvT5+CJcod26LVo
         TIdWeKN5MNnnDsZrT5eIDzzrwW/r0YIDeGEI84nceCbus9GuTHRYNuWnp9K4b9DVyxkg
         v7EU46q4Y5o6sTR4zZ7bJagrFyM/wWZTyLfHK89HGSRMdfyNS+iVLDTWwFT3iSN4mEAb
         6x+EBCPa6lXmn1IW+dDWtUe1hE3Zc7YbMH+4FgxRiv8i6InVsObOK+MEzVopZRPAUxJV
         /i2h035NVAoFZXXPkcH2cL3vKZq0Mxu2Xq0+UzQJmW5cBJnipewoR9pc/bNYDQywPSpJ
         rT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762704435; x=1763309235;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9fgHs7LNXxCjvnR8z+jGu2x4XIB8BbhT/m8R+mBEHI=;
        b=kp5vSjxQE2wBT1EJ5MBLcuX9FiaHehJUmJFihvQuWev8YnwmsGE9rPLBEj26rONxH3
         gNm/UVycZgIP6QL1qXo3DczraQC1Rq6cscvmWmDMsPva63SYh0i1M1VrR40MpmaaQ3Ue
         eUPzICWyuGZJq5ud481db2RqqPWKPra2mH7Q5n6TmXREuIn5dzoD76/8JL7cgxwcgrG3
         MzHMi8y4c4M/7T9EK85Skt+za4bR8W2Yv032zG76pVpc4AVxh3gi3E+OALUMtrv/mdhw
         PMw4J2NMSqRknMfnlYEUS+lxXdqH9TPUX6a/BvEQKEIHgQWI+18jxRYHWFexeGnbkJli
         VOvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Iuo0iiG/14lE15MS+PT00gkESFIRwJ/I1tFG+jOXYVNf5alb6NG2c4JSrk7HW1ogkVaeXfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRrtHJUOCelNhbNK4ygTkeKJAQopm8YR8/Nf2Dam8rIP0OsNEA
	N2AVSqAPj4SappZoJZe5zRLM3+DFObQbFGw+gmSuWIVbLtpiQTaheouz
X-Gm-Gg: ASbGncu10pyNwuUR3a2/eSEk/fhjm3MOKZLaaufpY2L5U/uGZTbS2TrR/e7XO7BT+pO
	/N+cdZD0llq6P/VkAuLJ7jUjStawzJAu7NaQkkem+sp64K6M8/H9YkIQR0bDGv9bW4NqlC/ffZZ
	5prQRHjTxwWmVgEzdCzMfmP9ApGVtb7NcxAi67TlHzmVMfZSkNmUYZ37izTuisVIFeP8Ve/6ZPM
	q+wTM8t74BvSDVfx3tbNPjYaeNqNkeEk8gFnGKH244TwUVtoC3D9qGq1sNCZ9uxmDEytTFQLzov
	5wV6fLwMb/2OVmp1ZHWU0tNMMWciNOeMZQwnAHi3E9FpJdc4jRvPew98eDmafcWG4nX6vXFyRVC
	iieNkj6/pmWUEy6Gzqhfh966Hl5Bmds9ADgqDhFNEjXHAYUJJ9HaE6oeR3CAfywQ0zkEmWz4FTo
	lclsz1bXspnJaSw/Ny1xKBpXNyqVFvc/WJJg0SUsS6jHy33wOySE0VxEYb
X-Google-Smtp-Source: AGHT+IED6bY5qY6cxFJr2d2ngprwv19bCwEkOcXrTloMgrXhgTLDjUOuHRGjxqnxhNBX+x9pqayApg==
X-Received: by 2002:a05:6808:f8a:b0:44d:baae:fb0a with SMTP id 5614622812f47-4502a280b80mr3116020b6e.5.1762704435376;
        Sun, 09 Nov 2025 08:07:15 -0800 (PST)
Received: from [10.0.10.56] (57-132-132-155.dyn.grandenetworks.net. [57.132.132.155])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45002798bdasm4627637b6e.17.2025.11.09.08.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 08:07:15 -0800 (PST)
Message-ID: <0947877aeb6ff8c09bdd3bfcd8a9d2602bc54851.camel@gmail.com>
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
From: brian.scott.sampson@gmail.com
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: christian@heusel.eu, davem@davemloft.net, difrost.kernel@gmail.com, 
	dnaim@cachyos.org, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, linux-kernel@vger.kernel.org,
 mario.limonciello@amd.com, 	netdev@vger.kernel.org, pabeni@redhat.com,
 regressions@lists.linux.dev
Date: Sun, 09 Nov 2025 10:07:12 -0600
In-Reply-To: <6980dba4ac0be1d6bbed8cb595d38114d89a14f5.camel@gmail.com>
References: <caa08e5b15bc35b9f3c24f679c62ded1e8e58925.camel@gmail.com>
			 <20250920035146.2149127-1-kuniyu@google.com>
	 <6980dba4ac0be1d6bbed8cb595d38114d89a14f5.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> No worries! I just applied this patch as well(on top of the other two
> in the order you originally provided), and still seeing the black
> screen upon resume. I am seeing a stack trace now when I check
> systemd's journal, which wasn't there before(not sure if its
> related).
> I do have the System.map as well for this build, but not sure why
> everything seemed to end up so cryptic. I'll paste it below as well
> as
> my desktop:=C2=A0
>=20
> Desktop Environment:=C2=A0Gnome 48.5=C2=A0
> Window Manager: Mutter (Wayland)=C2=A0
> Distribution: CachyOS

Just wanted to report that this is no longer an issue now. I had
avoided suspending my computer for the last few weeks but closing the
laptop lid this morning on accident, and it resumed normally! I also
tested going to the power options and clicking suspend there as well,
and it seems to be waking up normally again. Not sure if anything
changed, but wanted to let you know and thank you for helping!

Current Kernel Version: Linux 6.17.7-3-cachyos
Vanilla Kernel: Didn't test since its working downstream now in Cachyos

