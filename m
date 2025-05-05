Return-Path: <netdev+bounces-187832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 300B1AA9CE1
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 21:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD8217DE92
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674E5270548;
	Mon,  5 May 2025 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ifxYQIy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017926FA60
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746474946; cv=none; b=VISdAlZ1SMwlRU/PdHyWpgLRwafItf7EUzAdC/+GEAi5TBfHeu9/Plh80bakqT6Zfj//GDL/trS4n+5uHG7LFh494MwumBrqZdpsbHvT0xmEV9Os6YHpzkyixlnCqQ0U2zNk5hycg4ZuxTe0jxZpEZY4agWwsSYbPj2v3ni6pKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746474946; c=relaxed/simple;
	bh=RGhrUhERQwmWG22CI39MafSDQwomsfrX4WJjmiI8SVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUxvAdvj7+KcgD0f+filuGD/sYgeZHjQVPDj67tHQWjQddMQkpf1hgXpBGOyF64ukYbNxollnp7GDW0QOJr5nd9kqf2ufaIdPaHJxOFnTtvZwpRGl1nJzOOm+e4SK2Aei/EXq6vHkH9CIUa3rwjEeJhKCxtvhTivGeIEWksxnvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ifxYQIy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso241a12.1
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746474943; x=1747079743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGhrUhERQwmWG22CI39MafSDQwomsfrX4WJjmiI8SVI=;
        b=3ifxYQIyOhDwOSeIN3KE0ntPimLMCGCptHgd478SoIf6SUwuTtn1VsNPZVqj7eshCw
         l/QvKi8nyrh+lhesLmCqRRgse24R4Z9C0K3n+6yRZoHNVsbIpcDD1K1KSTPqrmMGIrwY
         L/4H/s9xA3IoMSWraR8QUbLMAetx416mokJo3GRVwB9wV/Ae32+HeTAMd5whJwzLB7zX
         /lHCs6p4QrwdNfmZLL+G3L51MDsSq4RXITGmeCB5XQcdh2rg6VZ5bP3+ZKaBHsKcTtdT
         Q//PSgW2077U0BC5EVxxdf1EQ9hS2cci6qn55hvmMSCirOkIrA/l3BnJigKcvPG93YXr
         FJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746474943; x=1747079743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGhrUhERQwmWG22CI39MafSDQwomsfrX4WJjmiI8SVI=;
        b=A5Z5tqxD5N+EBWh4IK10edbElvg19X6VE4T4x8mAlIXmxL0jSBXPNB7vBBKxsvmgsh
         p5mkRdX6g8slmO8xx5yA+l6p+Ub+rOrM0v5K7rI6SVLKYyxqh/iuK9ETg1RqARythj/Z
         dV349i6KXHAH3vni88ol5nSY17q1suVlw8sAUtHmvcu1rSG+IzKFBmwasb5o9T3oke5i
         lbPTePnmUcjTckxAhNL4sxVW+KcvGLLkpkct7QsJSkhhxO2WfnqcwKJYv8gp7LeN7/g8
         zNpcM+EyAB9i9Nr10Ox2WhCPzpDicuPsuL64yF7CrU6QSARsbwIxmnox9a8gfieXV/4K
         wn2A==
X-Forwarded-Encrypted: i=1; AJvYcCXYbhROal4I+yJJntE0rxPyY1ZpVthYjkKrxcYtPFc/nPbSewj37ajBZyP09pSgHD4XOR5g5SM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5MSGt+0AlG5x6VfMq8/vg4QMXWiBBYl1I0o0seR/k0dHz+Ylu
	tZOQLUTxooSDU8ze3YtNeXSay0NC5rX+Ny/LWcpe13DIiRtJK3d/Baudd2+BzV5oIVXb0o2QEIk
	lkg7BsRFucP4W1aXDY5Tn//iloo5xILPdvLyI
X-Gm-Gg: ASbGncu7Q6C/FckTUIOBBg8yTg6DBq+XmSZcM4hNszfAHYVk5i81UW4bSk0YJJupkdl
	OwlCUc4WFo182X/BSr2ZzKbRjZUPaNoIkQrqVIA+z487fd53+MIIxiDC8Z4nZBkIsfWG6QWr+E6
	5tEdEQl4VsOqDLrzbA3bUhnL0n/OtY6PaTOTIjRRqTA5IX8VyQTgDzDbAk509x
X-Google-Smtp-Source: AGHT+IE8pVv8vSvzVcyTPhfWeaAafX01XSZmjT3LXYmjAanZIAEnxeE4xHmNJ3sAg2LYV5sidxqS/G91rARIhm9ORDo=
X-Received: by 2002:a05:6402:1a29:b0:5e5:b44c:ec8f with SMTP id
 4fb4d7f45d1cf-5fb72db5ff0mr4797a12.3.1746474942569; Mon, 05 May 2025 12:55:42
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505193828.21759-1-kuniyu@amazon.com> <20250505194451.22723-1-kuniyu@amazon.com>
In-Reply-To: <20250505194451.22723-1-kuniyu@amazon.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 5 May 2025 21:55:06 +0200
X-Gm-Features: ATxdqUHmxqxtf3xEtL_3ggl9pGJ2mTIq1tYtwvsmbhM2zMKZsVX7F5lKso7edio
Message-ID: <CAG48ez2YRJxDmAZEOSWVvCyz0fkHN2NaC=_mLzcLibVKVOWqHw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping
 tasks to connect to coredump socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexander@mihalicyn.com, bluca@debian.org, brauner@kernel.org, 
	daan.j.demeyer@gmail.com, davem@davemloft.net, david@readahead.eu, 
	edumazet@google.com, horms@kernel.org, jack@suse.cz, kuba@kernel.org, 
	lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, me@yhndnzj.com, netdev@vger.kernel.org, 
	oleg@redhat.com, pabeni@redhat.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 9:45=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
> and LSM can check if the source socket is a kernel socket too.

("a kernel socket" is not necessarily the same as "a kernel socket
intended for core dumping")

