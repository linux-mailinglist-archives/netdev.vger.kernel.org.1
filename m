Return-Path: <netdev+bounces-159983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5EEA179D5
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3361885BFD
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119321BC07A;
	Tue, 21 Jan 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exg9+V3q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBABC2CAB;
	Tue, 21 Jan 2025 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737450555; cv=none; b=TF8uxngtt8LrKKhXfucXYdbg/StHXsuNjAKK3/Z5bzbevLsayY7lQ2VStB6m7dWCv9NrMJRIKF84EqQe1eyYI/pLAIcWDOIsIkaXT8uyJzXnWBtTwSYn1nAeGUUCRYvD8zJiuMgbwrWGgeAWxcP0X7SCMm5OgRu3bUXM2IRXEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737450555; c=relaxed/simple;
	bh=WvHm6i4Tr8hzdI5lZXs5wNmm1gALbmDbKkWl6p6plYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a84uZCPxTf178AttT5fQcJZdlCzaa6JB/F/yfQuGwZPMXtns8dYsjNcNtKdc9gjLh/Xk2+1f0QOFkQLK0O/IFUp890nBsrnvAjLo/nLWLPmwl8KHT8aYUanU9ZSFzq08V8Ft9HuZREANOjAJL8cbcH0DrZGkFycHwfNMOuELQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exg9+V3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F23C4CEE3;
	Tue, 21 Jan 2025 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737450554;
	bh=WvHm6i4Tr8hzdI5lZXs5wNmm1gALbmDbKkWl6p6plYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=exg9+V3qcugpZRV54zDjVe3k77ARbdnjZ/jgYOIuUlmEzYdHJ2gYI8L5TTImGk/RI
	 lKQhWUCN+nzTS6zWhtgOLvvSsI0M7tnxYrtW7WWj0KOn09PUn93GQrPv2wDeKaHPdv
	 NEe6ZnqPoPTqXmn9JfLPMuMxMikn8XkbNRMwn/OTpa9zOEMRdTr8lJ1eu7F+ojkwhe
	 67Ws8IYc+BSUXUtOeJ7155nZZm33AVJBntx8S2moTQgzD+k4r/uFQaunnQ8M7P9XOY
	 GcL7Uq/Mly+7NG8LTkX8VuZ0Rvl2qyAZDgF1Ip2VZumPmJ8yHryncoHG0A8qFFyK0f
	 jEe8ypmTnt9hg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so9443603a12.0;
        Tue, 21 Jan 2025 01:09:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUg9UtTC6k1SoL02Y5Ni11QMtfhX2yOSV4Vsh/agn7wuc4iOVEjqyZqO/1zKZzqZMzWS3ldETra@vger.kernel.org, AJvYcCWRBgUsfZMoLXN4G+ukPp1sUN8eEvn4CJkEKj+AsWNl8euk50VdQh5VT5rz7diDkW+7ozIA+7SImdDMPec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWjYBFw/WTAVKbj7Ye2G3euY/Js1pMSu9v4pgkWGxXvFPRPSb
	8H0sHt1Sil4Wly57MA/0eN83w70G80zDY/7VeH2pHyE4dWWzCFHSSUqUqSomaTuT+qEAEs8+C3U
	Y/zDBWeNjdmDBQfLYrocmP7+Nfx4=
X-Google-Smtp-Source: AGHT+IGzjrh1NA3o8A3+RhJG99XOWJ4NXJI25r2bWtBsxh1tM5KrsEouxThrIGAJgk8BTeRRbRaBycet+uCxNWi9AH4=
X-Received: by 2002:a17:906:4442:b0:ab3:a2f9:d8cc with SMTP id
 a640c23a62f3a-ab3a2f9eef5mr1134219366b.41.1737450552640; Tue, 21 Jan 2025
 01:09:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110144944.32766-1-si.yanteng@linux.dev> <5e1c9623-30cb-48c8-865b-cbdc2c08f0f3@lunn.ch>
 <20250110165458.43e312bf@kernel.org> <679e160b-6cab-43d6-990c-d1df0e243995@linux.dev>
In-Reply-To: <679e160b-6cab-43d6-990c-d1df0e243995@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 21 Jan 2025 17:09:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6YJyP2g45JdihZN262Ye0_LzWSibtc=6q7c2Rj-Dkzdw@mail.gmail.com>
X-Gm-Features: AbW1kvbZ_8LkZoLKR6xf5ayFpawG2Ft9AC-WoLB5kndGe7nh_M-PN5DjUIvKbO4
Message-ID: <CAAhV-H6YJyP2g45JdihZN262Ye0_LzWSibtc=6q7c2Rj-Dkzdw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Become the stmmac maintainer
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 10:11=E2=80=AFPM Yanteng Si <si.yanteng@linux.dev> =
wrote:
>
> Hi Jakub, Andrew,
>
> On 1/11/25 08:54, Jakub Kicinski wrote:
> > On Fri, 10 Jan 2025 18:22:03 +0100 Andrew Lunn wrote:
> >> On Fri, Jan 10, 2025 at 10:49:43PM +0800, Yanteng Si wrote:
> >>> I am the author of dwmac-loongson. The patch set was merged several
> >>> months ago. For a long time hereafter, I don't wish stmmac to remain
> >>> in an orphan state perpetually. Therefore, if no one is willing to
> >>> assume the role of the maintainer, I would like to be responsible for
> >>> the subsequent maintenance of stmmac. Meanwhile, Huacai is willing to
> >>> become a reviewer.
> >>>
> >>> About myself, I submitted my first kernel patch on January 4th, 2021.
> >>> I was still reviewing new patches last week, and I will remain active
> >>> on the mailing list in the future.
> >>>
> >>> Co-developed-by: Huacai Chen <chenhuacai@kernel.org>
> >>> Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
> >>> Signed-off-by: Yanteng Si <si.yanteng@linux.dev>
> >> Thanks for volunteering for this. Your experience adding loongson
> >> support will be useful here. But with a driver of this complexity, and
> >> the number of different vendors using it, i think it would be good if
> >> you first established a good reputation for doing the work before we
> >> add you to the Maintainers. There are a number of stmmac patches on
> >> the list at the moment, please actually do the job of being a
> >> Maintainer and spend some time review them.
> >>
> >> A Synopsis engineer has also said he would start doing Maintainer
> >> work. Hopefully in the end we can add you both to MAINTAINERS.
> > +1, thanks a lot for volunteering! There are 22 patches for stmmac
> > pending review in patchwork, so please don't hesitate and start
> > reviewing and testing.
>
> Okay, thank you for your encouragement.
>
> In the following period of time, I will try to review and
>
> test the patches of stmmac.
I can help Yanteng to review patches, and I also have some stmmac
patches to be submit.

Huacai

>
>
> Thanks,
>
> Yanteng
>

