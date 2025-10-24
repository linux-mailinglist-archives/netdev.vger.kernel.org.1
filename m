Return-Path: <netdev+bounces-232336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A1CC04271
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 04:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79A344EF8BE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48BF264602;
	Fri, 24 Oct 2025 02:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHByPPrG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6BC263F22
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273673; cv=none; b=AAefBFMgj/z7Bz1/3gl0kOTUbCtEKfkCHfK0vCKab6v4oi1oT4sYcB4JfEHa9bRxtgjPZc4tPGWl2j7qRO3nNLhG1NjSXtspOCIAOAYZvf/MTjx8PO2FJqjMfSKBeGsyv2o/pgaY7ni1RwO5hNBkgkobAXE7yj8XcX2CTOGnDLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273673; c=relaxed/simple;
	bh=95YboF54tH5QUvRm/hmBFW/Owf76+Rdb3bIAoi1mBHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyD7sWPjCEmD2nWpE84zyuDrrkwcWOv6nJO2WuQa9n+7CuFrrge3fYMQpWFzZSmFPu++uV5LmEZZZt5wdSu8yayVQ9QawcUaILWq7AqW9dERCzhroNACWMvKhPZrzPkpu3qHNAY0YCNo6acMlggtSycQhlxp7+3tGo5leEs3FRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHByPPrG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-587bdad8919so3804e87.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 19:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761273670; x=1761878470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95YboF54tH5QUvRm/hmBFW/Owf76+Rdb3bIAoi1mBHM=;
        b=bHByPPrGVGNBME39NDM7DzYyInHKZXSuEAyai2sNjnzjwkpIIOdFRCV1Ebk8A84KmP
         SLL092XajniNYsvQyYuA9YG1WfLlRKdJ030SJxNkglLdKLGSRg4I3dQa3E73VM4oH2tn
         ZpH4i58woKnrE0XUORt/v699GbpXbwtaPNNFgWKCSHm5AJ3d71NB8GSeJrjDSEYExhBZ
         DUgExMs/bBrdORmY2cFdqgPZpacZvOcoDPsqibdJBv96kmzipEkIbtxY+a7G8N33zQsI
         8PhTz9UMktbo5eHaA9py+2X5UQJV3ojyicO9Qsjh917iAh3pDiUVa3wWQVOVgVrfvunY
         qo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761273670; x=1761878470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95YboF54tH5QUvRm/hmBFW/Owf76+Rdb3bIAoi1mBHM=;
        b=T04RvIRAC7naplJuIDb1AHepUa76ibSi+QoF+K2S/5dZ03zn+N8RoR4nrnf0dwIlV0
         TyFwr/fIZhjfgvneFItOuY6K2iIQ04Uro8MK0a5B+mfDzEPIeZwfnv0yOVxKBTzsQ0Vz
         Pxg1PPk7n2PNxRCBhckQb7vnwmQSV1kjhN4PBgDa0gmOvpQYooKLE+CHU/HaYM1kLl0g
         0Jw0HqMUq7slGpsYINVmhiK9iaJvYZSJLGaJWZxKVkij0hqZ8S+TLL6mlpPXFk1CBy97
         EMo3ZVSygkT3MATWz6Do0FpDT0PPio9jaJEXgYeSIMx1rc0Y6EgXVLzqaVwLGxVK+hkM
         x+og==
X-Forwarded-Encrypted: i=1; AJvYcCW+ysEpN8R5zfkvWnVxkZWgXBmmeR6piZLBZHui6tdrjJ+5ECZGXt7G/hylzfdI7mdASVE+Z8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/k0H6GY5FpbF/FbVDswU7RFZ/Ntgwe1EbyU+Nu/LnUumMocM
	PxWS7fL2JVzouRRykQ2XxwSpcDPvx12LXRKGpVI1NMQz9hD4WBwVJZLo/7UvLcAR9AuCpBxn9/x
	KTx7CPLT4zVT3VeIjdOxv7BImo9Up1awOSudZiMkE
X-Gm-Gg: ASbGncuZ7z6TOy5Z/jozLYh06rzYy2LA2N1z2M9rHuRLolTnH+J70cqJEpQzX0iYK8N
	jpIl2Opit6QeYCAyY7wUkku77ZTCVFj2Y5x1WDXdj14+XDk+rAUnTlvGLIvwGgbCgcVH6VXpiya
	4Puw36JaCzGYJEYst6C7Xpl1d5b3i9GWI5DvvL4qJ5882ExLAELVyN7QTrYxxL2Jw82kLmMCuq+
	6LVhRqB8xDYiya7h8ug2CwndCYecynEi2XxawStdUr9jATla4ueQUAdlvqa
X-Google-Smtp-Source: AGHT+IHjqFgIWuDm7vTLkbQJe6dPh2ExN1tguhxjItVjNMaKUM8/M1t8ZmcBnb8MeAuwemGPGhUNlk1JAwuwKccnuAg=
X-Received: by 2002:ac2:5f0b:0:b0:592:ee58:60a4 with SMTP id
 2adb3069b0e04-592fb709440mr159459e87.0.1761273669601; Thu, 23 Oct 2025
 19:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022182301.1005777-1-joshwash@google.com> <20251023171246.78bea1d8@kernel.org>
In-Reply-To: <20251023171246.78bea1d8@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 23 Oct 2025 19:40:50 -0700
X-Gm-Features: AS18NWAb_LNjVdcEftVOiVwgVz-rs6pCDPHRwcZsuhICKQ5KS-oc4ABC6PYB2qM
Message-ID: <CAHS8izOynoK_7pGumZGefecdThsH=oXr1HJJ7+BQMF_ZyTL7=A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] gve: Improve RX buffer length management
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Ankit Garg <nktgrg@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 5:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 22 Oct 2025 11:22:22 -0700 Joshua Washington wrote:
> > This patch series improves the management of the RX buffer length for
> > the DQO queue format in the gve driver. The goal is to make RX buffer
> > length config more explicit, easy to change, and performant by default.
>
> I suppose this was done in prep for later buffers for ZC?
> It's less urgent given the change of plans in
> https://lore.kernel.org/all/20251016184031.66c92962@kernel.org/
> but still relevant AFAICT. Just wanted to confirm.. Mina?

This is very likely unrelated to the large ZC buffers and instead
related to another effort we're preparing for. Not really 'urgent' but
as always a bit pressing :D

--=20
Thanks,
Mina

