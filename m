Return-Path: <netdev+bounces-221280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA979B500BB
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E953636310C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B912352075;
	Tue,  9 Sep 2025 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F+aYY5Il"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67060350D6E
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430755; cv=none; b=tWfdaRQ3DmqkdBD+PA3OfYC6t64rMYO+tSsO9tFLQh+xaz4jeSR7GXodzAxIRI/mZYTWi5lBkfNwnEf//TNvQ8O8kKsfmo5Hoh02zvSPkawQo/2TzbpD6tpDUcGFtCDy4DKdmvSJmd8d5y7+0uJHQ4Hg3LbrXmxGxGx7iDWQovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430755; c=relaxed/simple;
	bh=vC0RhrPrcMkxot37144PIqQTE1U38KkVfhawLeqOH0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qexp5uQ0N8wqIaq/urRZPCR6WELJwg+QANv4KtTZiCHWNMmTC84xktNT3XKc6uweLVE/1g62v3El1chxYO9u+j4+o0FIQf+bJPzb5ZNwqkHgvPBuUl0/RSOFquRXDxOd1iXiwLYJqxTuo/5ClH1gaKgeq2ypFOtHIr6d/5oh8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F+aYY5Il; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-336d84b58edso58131571fa.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 08:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757430751; x=1758035551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC0RhrPrcMkxot37144PIqQTE1U38KkVfhawLeqOH0E=;
        b=F+aYY5Ilnfoiat48mWtuW67DwYUSdpXCFAmK9onYrjq5Z1F9NNHAA4YrrbLnZto0F6
         s3ispx7EUjqzWfIDqGN/IGtWxHnZoMxlN6xUplyfXsOImeDTCe2vUD9A4M7yP/lSWqyp
         9HmmgVQMNsG2C3Oti8uLCC4yAwaBiruNuA4I5mvN0hQtdPU4I7DzFJtIYNN4OCNpn6Ej
         PxpCyMlPsfAsfLrMHQSctn0WhgY514km/SFK00s4cDvRTG5WYEaCd2vEyFb6sJu++Get
         qYRChpXtjrcsVcN8AcHnGpC9seLfiIB9Aup8ffBCvh2RbtwmMFpeyOV6ibdoNz+AuQfz
         6Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430751; x=1758035551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vC0RhrPrcMkxot37144PIqQTE1U38KkVfhawLeqOH0E=;
        b=GEok6ou6Jax6CjLXaLNeunDWFeyjCSH1ac9gwEhgCghKgSBi4g0+Omd8TEuthrPCq5
         HPCZq21YCF8kT9pb+lQ1PBmNGjzV41pXcY+oyu6+4HPounzHmt+2igB1QK5AUFPi7Q6i
         MvAi4uXEPfpQrQ3GWFnu3eQILEAba68AjYgKGsESHjzGBu/1kJI0HDp61HNDdWIaI0fp
         ue7o8IFXhH8dwpNbJ29xo/AxpnqyWe0BdjW+Z7NQZ0ogNJcobWUrlGAQ/5UPmdb1LuRg
         J5RNZN7QlrZDe7l/SoFIQajHxyzgb/aDGREMLwgMs1EQmPn6cExC7VMpl+MQ5bzDiJYT
         Nd0A==
X-Forwarded-Encrypted: i=1; AJvYcCWqRyba7ZKbaP5D7rKkDO7wRWSXqo6zTZ6Ii2TzxSjj3TRqXQbcoVCHQgmnrf82jn/EbPBHIvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxORoKFAU/35ewxAaivdeHsfj+p0A3FdXcLPLH/ECyiBQgSV/1o
	xtC9Bhjlqp+4YiwzGekrxpbXNYTHX/ZZe2g0F7fgD/s7ZnuMuh4Wo6FHT66Sg8SoV2vWUkGsyVl
	LgQOd2uoiahSSJb6EZGYVm9o3NG/z9rytrRfGiFxv6g==
X-Gm-Gg: ASbGnctmWnjBZswhvy5xTC4S46JTWoTH7CY/B1K+3nTr4vIk0p1F7qo5hx2QdA457ea
	iiUk99wI48nwTYxmlME6U8nWnzNMV3rY0bNWLaWmkKC9rnE+/GY1qadJCo7e2ISghzU+nnBuEYT
	W4f2x90WPUlpU2d47c6AQuKf5RrBiajbpNlkY7z2v8uszzUmSaxXcjkCBMDjcant++Kq2Efwhau
	Ei56+CqYYYWLyfPbszQ2Wy2XJsSdb52fob53+vS
X-Google-Smtp-Source: AGHT+IHcM/qCmdaFBrMHj7Y48h62zSWt2aNavN8vBrUsUsdCwso2/AZxb0LP6AaYCmye2e9PhnXeRlj3XuGYE9RbURk=
X-Received: by 2002:a05:651c:20cf:20b0:335:40e6:d051 with SMTP id
 38308e7fff4ca-33b5464b56amr31929051fa.44.1757430751426; Tue, 09 Sep 2025
 08:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090505.104882-1-marco.crivellari@suse.com>
 <20250905090505.104882-4-marco.crivellari@suse.com> <aL8H2VtN2dw1a8B+@devvm11784.nha0.facebook.com>
In-Reply-To: <aL8H2VtN2dw1a8B+@devvm11784.nha0.facebook.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 17:12:20 +0200
X-Gm-Features: Ac12FXxFYXEyAS9eK_KIEnN8Sr94_Mh33qSGPnjAXesdFD-iR1DWTt4CfOssh9U
Message-ID: <CAAofZF4dP6MJYZdwqsCTprqQyC8kimTuTKR_i2_k5o9tE38JJg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: WQ_PERCPU added to alloc_workqueue users
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:44=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
> LGTM for the vmw_vsock bits. Regarding step 2 "Check who really needs to
> be per-cpu", IIRC a few years ago I did some playing around with per-cpu
> wq for vsock and I don't think I saw a huge difference in performance,
> so I'd expect it to be in the "not really needs per-cpu" camp... I might
> be able to help re-evaluate that when the time comes.
>
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

Thank you, that's very appreciated!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

