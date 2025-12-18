Return-Path: <netdev+bounces-245439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FCBCCD782
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 21:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 165B230169BF
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 20:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3994328A72B;
	Thu, 18 Dec 2025 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WC7LROrX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D186027B33B
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088290; cv=none; b=h97IOUBxKC6A+9itiqGUn2AVOnFFkjmoOb91a5hT0VdMTQqzoh9a+OWnXGeb4+5kOdizXCxJLSzrU/MH5btOlHQxMeFeeZ29S3ySSQteJkSDq0vpnzhcEc6GTHiSWI+YprHwXjNI0bN34Y34saulknpPd96SZKQREg7918peaks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088290; c=relaxed/simple;
	bh=QFKwqkuCoaSNQ1rWrlhOeZojXlrL8l+ReaN+gIKxVYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUOhmAVtu0xco7I8e1ynwPCFCM9Sd7yHG6WECxNQ6RZSe7FyqDkqx+mnaBCLvXTBCu+1lYjHbejFSuDPd6v6mphleiiQNAnP+zw0bStTSPVjXmItQ9enJPQr497R08BZ07na99gGZVYVuLclI/2KuGi+0g0FHM8CKKDPgMe9B8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WC7LROrX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b725ead5800so150271766b.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 12:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1766088286; x=1766693086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+eXRG7wIdwp7K9wyhUzirolhQ1g6P788jXAJfxYZeQ=;
        b=WC7LROrXOM9CzQ/5s5Ln03PsS+s6zKg8ceILp5pvD4xSd7W8awbOEQ4iK/iAhdoBW/
         daVdlTpvJQZ88qBMBg+QoasI/j5tOj4UA2147TpC9GfvI5J512dLO4usngrj82pnIr71
         9Ry/AWpe4eZgNiI5WWIzXCoCki+q/kmbSoPfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766088286; x=1766693086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+eXRG7wIdwp7K9wyhUzirolhQ1g6P788jXAJfxYZeQ=;
        b=PqNJv3tFofOo4ZqAX/QhljjAAZk+hrPVTz1V4iWCRhIPzmUc6wSc0pvKX//OUfNwpG
         +YSJSzuPClUhslAKcAM8UBiOvt1UQfmPnANVkMgYKU1Ual40SpHUz47UfO1H13d/el08
         MC1aE5RvZhO+BXNeNmLb9c1FcStw1q2q3tPoOgFYq3X9guh63nPvWkb+jWH+kBqw7YiA
         CN/1706SLE6mD1nwNnIQzCkaOIlUmICm+LfBKxXymVS/Jh5or2aQXR7GKQYKHqEAhMjD
         /zZlLLa1NeCL1uKffdXs3o/aEB0wdVfHqJKlCs+gfp3bATrYyilNEwUUPvF7HHUVAJOH
         lxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfSoTKy+awE/rawCGkQHVjmyhS5ZDwvqmJWk1Dz0z0m/Al7Ps+KA+coWODg9aIKlnvv1j0G7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9j24kEXl/WkgB/PTn5oQPh4e5lFiwkZo6uuj8FeQdFItB3ZSc
	9eVVu6phglEdkLty8ERE+itKl+rNzHDKwz4LIzQRJvKhAZQ1sACRcDN0Uru+i9iDDxb/zhzahi6
	BzKj2BMjFWA==
X-Gm-Gg: AY/fxX6lXxV+/Xd4uzFiZf2JxFD69Z53GHuZ66/x0EHu39EGYsPdiMu65NYXEMDYGJJ
	LI5V+Dt3Kh4yv+AIhiJadKy3AdxrSrqsWpnCIjOdfqV6TICa/atc/VctazXeAJeitmSqzriyn9w
	DyJYQDG2ANguvmJ/g9YegFACNVN3COKRSpoeZXd7y8XcgmkaI3rRtBRIuFXm9u+0ZkKdIIRc/QA
	nRHmYbsFNsdhy3tDrEqMoFFOZHz4zS8YFTPYlXsGhiKOJjst6w5jMO6UVNT2Ctw7PJfXMJvJlKU
	T084BeeYhrbHEqqr6i47KXK5sI/FK8EJpHp+Og9QHBmNYnaSQ06/jbmCyHB7bY9dicWBljrKkso
	RxXy0ckzF1IU+NotApqlg72l6vnKUvtfSCNw9iAvlsHNP9plyRm5Z4aASD6SIYnh9SX9UIIRvfb
	EF3alrs62ZFdCh+try0gTTKL/QidGB/qnlYh7/PJ2QWDjEwAaU+YS9+FNM+Tbd
X-Google-Smtp-Source: AGHT+IGPS/1p0IoFaA/+pIgXPS4zc0eyrfhhc3V8G0mjwKKzYdmBvkOiQXiaRLOj6q/YP40ZTchKRw==
X-Received: by 2002:a17:907:7f07:b0:b73:870f:fa37 with SMTP id a640c23a62f3a-b8036f63811mr52600066b.17.1766088285985;
        Thu, 18 Dec 2025 12:04:45 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f37ee8sm25053866b.59.2025.12.18.12.04.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 12:04:45 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso1332640a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 12:04:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYYdmk+VL3Bhg6YNjfRlCtQS449SGnYAzhS9d1+RHSsj2XTtoXxf6h3QtRG3eMC5ZiRoIvU0Q=@vger.kernel.org
X-Received: by 2002:a05:6402:2115:b0:64b:3f47:6d85 with SMTP id
 4fb4d7f45d1cf-64b8edd94e0mr499331a12.29.1766088284954; Thu, 18 Dec 2025
 12:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218174841.265968-1-pabeni@redhat.com> <dbb8af8e-7330-4130-a62e-e05f490f19be@redhat.com>
In-Reply-To: <dbb8af8e-7330-4130-a62e-e05f490f19be@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Dec 2025 08:04:28 +1200
X-Gmail-Original-Message-ID: <CAHk-=whWLgrQjmVJk1bR14-7p9sc1wr1YvzsB=pxMTvxuhHDQw@mail.gmail.com>
X-Gm-Features: AQt7F2olPXIV8viq4SW-X5nDaYvlJZq2De-naEF92haNCiKDP4gdi0WcoyRRai0
Message-ID: <CAHk-=whWLgrQjmVJk1bR14-7p9sc1wr1YvzsB=pxMTvxuhHDQw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.19-rc2
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Dec 2025 at 05:56, Paolo Abeni <pabeni@redhat.com> wrote:
>
> I have a question WRT the next PR (for rc3). The usual schedule is quite
> unfortunate (25 is the important day here) and I'll be able to process a
> limited number of patches in between. I'm wondering if postponing such
> net PR to Tue 30 would be ok for you?

Oh, absolutely. Please don't think our rules are so black-and-white
that a few days around xmas would ever be a problem.

I'm planning on doing an rc8 for this release anyway, just because I
expect people to lose at least a week due to the whole holiday season.

The only really hard rule for the kernel is the "no regression" one.
Any other rules we should be flexible about - they may need an
explanation, but they shouldn't be seen as some kind of "set in stone"
thing.

And "it's the holidays, we're all busy with real life" is a perfectly
good explanation.

                  Linus

