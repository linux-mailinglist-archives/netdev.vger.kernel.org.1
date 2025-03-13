Return-Path: <netdev+bounces-174485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A6FA5EF79
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05FA3BA2C7
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853682620EA;
	Thu, 13 Mar 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEk7Ukvu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE02C80;
	Thu, 13 Mar 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857795; cv=none; b=lL5oOeY6kwyc50OdIi7SMb7OtOZRUHXZ47/wtlKnTGwhuTjfmjuSyBb6KeyGlOPCFYruhwBmZR0+Fccl1IUD5h53w9JAt9WXAo+AsahGuQl1dUhQc0euQDcoeLmj/vYkVlRYHlvY84CYCn8khqtRYTtabJeZVAj32tRz7VIE0Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857795; c=relaxed/simple;
	bh=EEnLBbWizp0nZHlYjsOWGzcAlEkxjxn9Tok6om06FO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJPYDLCV0UhCfGdGdHDjQagTpdmrLj2bQgR0DA+NRq7ggdVQSU7vVhy8AuFQsy/JQ44BYsTc7FsSxPwJ3pubjqj8ZnDume66fKT2eXwVu4nZoEEF3UJgB0am9/pkKKa5I9DKZu5a6w/flAUU4tcaHzXMLBWUhwPFRu1vFgvhPmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEk7Ukvu; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso589632276.3;
        Thu, 13 Mar 2025 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741857792; x=1742462592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EEnLBbWizp0nZHlYjsOWGzcAlEkxjxn9Tok6om06FO4=;
        b=kEk7UkvueK4bMO3Ik/QCxqT9MyWxmdzvuuvP5HhLAu+YLneMZg/TFphp3vC0X4666N
         WuNIxcYxHdORLjJTxl6rBkJMxx7+qY9UUjSTjWpvO0mXheGyy4p/l7G3NxMcBaJ+FGnf
         Su1sffwvrNVp4tYpTUoZ/qd/OyEIwlsxP54mP8otLBu53Ryz0czNDKS9ufietTMXTyau
         KGYq/cn6nD0n4uObsrIjVpHOe8EfkJJGw5fhnohLJ+PZe9bB4i3NzgejHeEtWT5jFDTY
         mpYyRMPF19ZG4ZnbksrDlmsbcFI4/+e1wRnvOnEpi8JzKXT7tdpssbI8I67+aHT++b4e
         csOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741857792; x=1742462592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEnLBbWizp0nZHlYjsOWGzcAlEkxjxn9Tok6om06FO4=;
        b=CfxuK9wSrm7G6IEyVqUQlzMmCIh3c0fXiqTVf7jZEw+j8VZ9mpQcbfvS2m5V64C0Ll
         m74F1JhD7fhR37wCm48PWT0D5zJTj+bIzzwhU8j3fItFIVQvmAOtiSeh64SPSlPAcoSX
         dD6oqPVBy8e5NBBggkpw7KovRjYHSlIDCuFnBLgBtd6tHKVKae1QjjfDAWmviOJIYMjZ
         imsuj0rZhi5YZ1gMd3NWRnlUMZLLmFDjFRIqe8BMQ501VWHHz9Y8gKddHoxNW8tJr58+
         iq5rf4dqBFTwGDTURI7uNWDfWQi9LBmsRkrmMprneTn76Ht/mDqpB2UIqoKw8IJn8W5J
         Q+XA==
X-Forwarded-Encrypted: i=1; AJvYcCU/vws2or34Ccq//GPyHQzYEMKVhFsqyslZMLTZUTHoD/+Q+cnVGlZVZfpqFeQRfC+HasDi+xAlgjYv5Ag=@vger.kernel.org, AJvYcCUlvYrIqwGyQo9PP+uqaLqMq8T3KZfayfdj3jiSNBHIkocgOLoKmQMlnC9KiKW+h+A1/CKCmyPc@vger.kernel.org
X-Gm-Message-State: AOJu0YwrHMOWl8xLgwlYMfWtY0nNcj8yATFowfHE7ovi88Y3kMh9SmC6
	M5Y86vaXpYqeOwAn2OVCM1/eKdwVIQxpV5fzwi8xti3hEPvmVKyEOtq8aYspHtapaLUIthvnebl
	b3R3mUf10A+JH+gVyfzCbMdZ3pw==
X-Gm-Gg: ASbGncuBY3OxASwE/qufcECCJffuR2BrPOlEvBLEGVAu+L9jFWJN43DGu9iushsrytv
	QeOUUlk8MIFiBdHWAMCSvWqdVRiHPh0VYdbcdZ1ThJ4XlARficF8yvnKau2JUMpxU65uLab6pex
	LBGNH7sfp3BKWdvoEzMRMJvybCFIbZAzfmGGvOgQ==
X-Google-Smtp-Source: AGHT+IGT8Og77/CyQESWI2ttU0ZO9zGAeHSoivfOUaJh/xn7wXEIcY4XZVlFZTHk+iV4y9PcCAd/rDMWkD8vCQHnmRw=
X-Received: by 2002:a05:6902:340c:b0:e5d:d9f6:d804 with SMTP id
 3f1490d57ef6-e635c1e35d2mr24638876276.38.1741857792357; Thu, 13 Mar 2025
 02:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307110339.13788-1-rsalvaterra@gmail.com> <20250311135236.GO4159220@kernel.org>
 <CALjTZvaknxOK4SmyC3_rN5eaCPqd7uvx52ODmDuAp=OeG0wxAA@mail.gmail.com> <fe021b67-94f6-43e4-9130-7b9a58919b40@intel.com>
In-Reply-To: <fe021b67-94f6-43e4-9130-7b9a58919b40@intel.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Thu, 13 Mar 2025 09:23:01 +0000
X-Gm-Features: AQ5f1JoeZoZ-bOpNnT-gc6-BaEs4WvxS-tLIToyOoqk_ZxeFbyjGj8vUu3-OXbk
Message-ID: <CALjTZvb_=NaNE=DS10G=61WK2xXQO35d2sYOd9L=qJ+TtpeeXg@mail.gmail.com>
Subject: Re: [PATCH] igc: enable HW VLAN insertion/stripping by default
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Simon Horman <horms@kernel.org>, muhammad.husaini.zulkifli@intel.com, 
	przemyslaw.kitszel@intel.com, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Tony,

On Wed, 12 Mar 2025 at 21:43, Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
>
> Unfortunately, I'm unable check with the original author or those
> involved at the time. From asking around it sounds like there may have
> been some initial issues when implementing this; my theory is this was
> off by default so that it would minimize the affects if additional
> issues were discovered.

I thought about that possibility, but in the end it didn't seem
logical to me. If the feature was WIP and/or broken in some way, why
would the user be allowed to enable it via ethtool, ever since it was
first implemented, in commit 8d7449630e3450bc0546dc0cb692fbb57d1852c0
(almost four years ago)?

> I see that you missed Intel Wired LAN (intel-wired-lan@lists.osuosl.org)
> on the patch. Could you resend with the list included? Also, if you
> could make it 'PATCH iwl-next' to target the Intel -next tree as that
> seems the appropriate tree.

Oh. That list is marked as moderated, I (wrongly, for sure) assumed
there would be restrictions when mailing to it. I'll resend correctly
soon.

Kind regards,
Rui Salvaterra

