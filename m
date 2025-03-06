Return-Path: <netdev+bounces-172268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41434A54035
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 02:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFF616E131
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 01:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED1218A93C;
	Thu,  6 Mar 2025 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBro8awu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B4BE46
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226362; cv=none; b=ey5UjdWT0bQK1zM4iLOWW/+/h81q8M2BvKmG04az+rD/SphanJTeTGG2lHjdJqRzg3hxGhzRvA7XpTClmmn7i951qPUdiyajJXQGKlWjmoR3XdFPVqDZcESS8YHj9az/EXXIiE5NvQeco6CGAohbcfj4Tj1OfYnvwvkZ93vh9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226362; c=relaxed/simple;
	bh=tvrqc4zCbJxUdqr78VDMd+T7jAatSN0YAG9zmzH1ymQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4NPsluERG1oLGz1n8eV3ziSr/c3DABdCtDxBOlgLuyguVjYI8U8Tuu3mnyZ3bG6YzDLMr5sLTScAFS8rsZ0+63kFZgeIrnBrlF86PVOh6fsVLiEj1catXqfmMd9isKrWdy7HHuqRO4Jt9JfFf6aOtmmBRt0yaCaqNx8P+9dH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBro8awu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE689C4CED1;
	Thu,  6 Mar 2025 01:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741226362;
	bh=tvrqc4zCbJxUdqr78VDMd+T7jAatSN0YAG9zmzH1ymQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZBro8awuN5PXrmNQ6SA6Aez5mUZ0C5y3HWzf6pHeChUVVkwko05tpZnXF7gFZGm9k
	 iHsHLqEtY5Yhzvla7xz/9LUXPEOniGSGKe8UtvAf5xORSiYLa1jrOibj8gcszrQOGL
	 yqTYhrt5I+cVevu/XKnWAHvznoSfuZ/Ml5uATf6odiYYmX8nYDi9ZSK3dlUojx6H/d
	 rigKF2bzX+EhmFcywVqBR4bcIPa3eLHzA35R+qPzP9tQTzav8HAkG7Cm+4S7XvEJ7x
	 nTAxWT6iBRhvVcZGKdltjIAzEUzIXi0iLqnCMSINICNyyOaHnrWErQnnKHGmD6me8v
	 5L5GDqkFiRwAQ==
Date: Wed, 5 Mar 2025 17:59:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: hkallweit1@gmail.com
Cc: Rui Salvaterra <rsalvaterra@gmail.com>, nic_swsd@realtek.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH] r8169: add support for 16K jumbo frames on RTL8125B
Message-ID: <20250305175921.132b10ce@kernel.org>
In-Reply-To: <20250228173505.3636-1-rsalvaterra@gmail.com>
References: <20250228173505.3636-1-rsalvaterra@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 17:30:31 +0000 Rui Salvaterra wrote:
> It's supported, according to the specifications.

Hi Heiner ! Are you okay with this or do you prefer to stick to vendor
supported max?

