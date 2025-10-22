Return-Path: <netdev+bounces-231799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2190CBFD8D6
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B743AB697
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9F227990D;
	Wed, 22 Oct 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="bgd9btfR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83826F29B
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152818; cv=none; b=By01SXeSfELfueRDJFwQ7u8GeXAz/ni5B6Q6FvJB1e6m1XZogdourjuhYuh7TmMQJd9R8J4civPYneNZWO9zS6RAVqiHXso76xz/P7qaYCEWmhJU5nKY8JS+D0wx5y7lxipSmQaiN8clp/T6CGf4UNYKFsQhONYnwOFs83xQtM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152818; c=relaxed/simple;
	bh=VH/G0c4QxyHu361KPwLMEp5dAEmq2F5Ui1BgioRWhtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcPbkhQY2iVMPhQ8DW3srw/JE0YHDs3qfnffvVgldUIov4OZMysHXHtiQopgCyuDTjcZF9gtWeZChDd+8noSGZ+DTSLRvbp7CEWfEJoRPXDPJ4f6+oRhfnyGaEiZgzst9EV4JIaEnOMF0XG4Tc7JxCDr2p2IsmPE1HSEEAKin0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=bgd9btfR; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87c0ea50881so137608486d6.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761152816; x=1761757616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCzgcuEp7CAzGR7HOOdsOQiZ4DRoGV9cgPFzNpkV3rQ=;
        b=bgd9btfRTbi/XNPi36wEMR5OVepiuLXkHFJIRZbreMpIrZ3watLjZAaI00phtQc/A9
         XqmrylR4SJzIbHyLyEDDH5fZvSbJHQ3b6gLrEPIWNEu7RQgSRK3htgFxMiS/LbMGQsjk
         AP31KfoyHxsZNj0W+0f+zObiznScv0oC0jvGkio/KDuO4w4Q4Wz9DEtzMBAhcavqFsPr
         SRpaESHkb+KLGdc2AjsDU6JiqEHt/sZDR/0coFSzrRSeIuazDJaiFvZ70Sw3vUdyCEkt
         zhGtsY9BgPKHUbvqER8zUZ7TGPZLdRlaTdg/hz89u2FzbR0qWYw817gc6SspMCEtx+SQ
         AWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152816; x=1761757616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCzgcuEp7CAzGR7HOOdsOQiZ4DRoGV9cgPFzNpkV3rQ=;
        b=ghWun+gyM0RTHmhtLtwTZWvQ9JwKuHQMhlUtTe4TbT/Y0wtErGgJZq5Tlir4f/5QJp
         yye+tDct52cc21u8a7ffcSV6/WzZXbgoEBl7Aue5GvsGe1BIPqd17wLDvSlzJQ7PHAQB
         yFQOgLJsKPeBJtcBuJjCdKiDrgqJ+FURDahSVr55nAndCr/UwC/QLAHWUbGVu2SYvTWA
         NcBEVEgRkBOGpDnM1gQ/y2SU35ZRbzAqa9FCDkCHPE0oiT0yaV8+rs66qaOjgdBA0gWH
         vH0r29P7lD6+1ZJOzsNrX2u5btAzR9Ep22mY3ZzhloHqO8ry7IlImQ0oNKUVuLF/a0La
         SpPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwphTQ0jVzLzt8MEl4kbCYL2exGjEb6niACSLUQa1HFyk3WPlEQXioIO4wnYJ6yP7GsGWT7NM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQn571F41cVDEjT0J2L1oOIfz5MEmQRQKi+tt40s5W9P6svMwt
	UZXmXRHUF+dzP2kyiYo3nTCr5VbjOk/bDU+hBbS0nDpRM3zituXoreHALXpfoGggXrU=
X-Gm-Gg: ASbGncuATp2K7jGAGWY1Kw9aw4yL2aGnTvBuKU95NVoiVwKHzqTjqAU5ie88znTw9m/
	od0DphuN9lO/AAunzIhaPlNJhDZAV/Tbv6ZfxS/O7z+MCpnvMJqzjQBQ/Zk54iknmbcKnqd3dbv
	OgwPvTt9rAH1fRIebUatjeuIPuKZ9UHrnRjnJmzZaqg1Zeag6BmwjCKseF1mD52JskhrQq6mDcl
	BRAUhOH12JZexZD5fEuwxYA7I7uAQuZoIIhCrMdkksPm6BLjM4ZAMpYeGwV/dsa8TiWHNgQIV9b
	o5n06aNGqDyPKfRRjabQLUxNCHa8Fu/GDUasKGl0GldyBYr8kTf71SoYJ/r37unbhTbcQmb8O9W
	23ymaLalEjo21wCPYLbK+Zcz7GXdpzzGI7Qlfmt0O1kOa8yF+6eNXGThceiRUMVUEaUwKiArbNj
	ge79FC4gLByGUwhziII77+HnkkFLpFCZH8xoCb8tA0zryKuOQd+w==
X-Google-Smtp-Source: AGHT+IGdWbYTC9vzHNEAyIcGDx0IUkeY3uAeA6cyKPnhJbJb50wH1hNHVbvM7ZjgflV7wWsYLpjhuA==
X-Received: by 2002:a05:6214:e81:b0:87d:f2ea:674b with SMTP id 6a1803df08f44-87df2ea69b1mr81407816d6.58.1761152815577;
        Wed, 22 Oct 2025 10:06:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf51fd099sm91187006d6.5.2025.10.22.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:06:55 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:06:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Andrea Claudi <aclaudi@redhat.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH iproute2-next] mptcp: add implicit flag to the 'ip
 mptcp' inline help
Message-ID: <20251022100652.6d24c0fe@phoenix.lan>
In-Reply-To: <946ceea8-eb58-4140-aa5a-94605cd697ce@kernel.org>
References: <0a81085b8be2bee69cf217d2379e87730c28b1c1.1761074697.git.aclaudi@redhat.com>
	<946ceea8-eb58-4140-aa5a-94605cd697ce@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 16:49:41 +0200
Matthieu Baerts <matttbe@kernel.org> wrote:

> Hi Andrea,
> 
> Sorry, I'm reacting a bit too late here (but Stephen applied the patch
> very quickly :) ).
> 
> On 21/10/2025 21:26, Andrea Claudi wrote:
> > ip mptcp supports the implicit flag since commit 3a2535a41854 ("mptcp:
> > add support for implicit flag"), however this flag is not listed in the
> > command inline help.
> > 
> > Add the implicit flag to the inline help.  
> 
> I would rather not: as written in the man page (by you in the mentioned
> commit :) ) "Implicit endpoints cannot be created from user-space". Such
> endpoints can be created by the MPTCP in-kernel path-manager in some
> circumstances, but if the user-space cannot set the flag, then probably
> better not to add it in the command inline help, no?
> 
> If someone tries to create an "implicit" endpoint, the kernel will
> reject this request, see:
> 
> https://elixir.bootlin.com/linux/v6.17/source/net/mptcp/pm_kernel.c#L813
> 
> I can send a revert. I have other small changes to send.

Thanks I reverted it

