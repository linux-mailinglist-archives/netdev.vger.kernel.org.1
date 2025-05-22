Return-Path: <netdev+bounces-192606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ACEAC07CD
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF9B7A3B4A
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B402268FC8;
	Thu, 22 May 2025 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGVbwsPY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F3262FEA
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904044; cv=none; b=dQZ1UvgaJXB//N+rsaOBKxm4Uj/iwS9hXV3E8zXEzauPqV1s978AqkvA0Ha8oq9Fag41cQuqKT4gLQI0HpO2RLmiklKIH3+mi1oKQEOmSTX7AL37vXrWX2i5snYm1l5t8w2kF4OFVuQkEoonMo7meQihhAmX4VNeQI5wCjaLFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904044; c=relaxed/simple;
	bh=VeaiAKCamGH/5KNTUY8LlityzfsbvxHoTWjUx8jGJKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1vqp7vhiA5OfUetqEErzGXpBT9N1LUPaHeRTB1Q2vewn2/DqwCOddx2JM4gVJCSHDJWuKKrQPaBsNLiVGJwkM660dBEgOGmUZFaJ+5Cya4B5YcifKBuJdyUFbUh9pkCN/oJb1auqsWO0UfSMfN8SIxsk+yvjwhJBUpHWEZpK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGVbwsPY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b26ee6be1ecso4332972a12.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747904042; x=1748508842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsEDHBZOOtazqkfVbNehyiVOpjWayP5/qV2gqESfGGw=;
        b=OGVbwsPYIVnIGJll++0rSUi9iS66/JhtaYHd0/TWpOZPuXo74mSQJ9g+IQDh9LO4ZV
         NJq4VNasIrS6LxowcIxrrZw51U3apuefYEhpJjDJ/9+Sb4Mq4eU1am93W6TEELjmWDp8
         LvsNqwYxmKh1wLsYr+NEw0TDVo31R8C7JoZHpCc5U2n7584PDyRZkFlCaawp9pvx2Xlw
         P5ZJfa5qrW18fMxTWgOp45uZbnB28Y1HKOOnIAIuwRrVoiGWG9fqJxr6f6U53p7Rw1fr
         MAG/ZYuC/oJN/E1z9EsRT541vMTa00Nun/qnmlo+kEhovZ/ZhgAUFkocQmBwxoiFCQJ0
         Vj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747904042; x=1748508842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsEDHBZOOtazqkfVbNehyiVOpjWayP5/qV2gqESfGGw=;
        b=VjkblRwkKOa6qya/po+M7s4DPqwYaq2XcNm4gKg4jyQarKQKU780fsfMYYyCnNGX0u
         JXXK2HJxZY05gIL+e6SBCUxVvDLzWkxcW5UHS/bHcoRpMKbjUJzsn3IDg92uscVeY5sy
         euvvWJU+7k3thpBIgweT/Im7HRpkH0rPLAY7XuK2b4sIsNw5zYvSngNTt/FLB4/wEJ3i
         nFWzjyf/pQJNqycpe4j1Qnzrm6Jjbx0hWM8PJ0e0bYmLaqeC2CYopM+BGf6FO9WWx7A6
         MG0vygfFkfwlbxUcsIGJU5gLldSiR+hzoC0cURFpk6q62kUFAIXeIuFGabMrxmDuEf4B
         KBZA==
X-Gm-Message-State: AOJu0Yy4M4SCTVpgZmOxFBFDny2zZZkB2oi/J2Pr5RN4bQr+Mdq6Kvcw
	sFfHrU1E3gegUdlS9GptLD3KGa9UEYk62moqBtDVYIDZU+iFgGtugtAaOS4O1JDd7cvYpMgeCNS
	8M+h3E0spHCLqX3UmTscuohjAK2ILU/g=
X-Gm-Gg: ASbGncu9+m4NpkVtKBIy1XDuUz4SB44T4c7fRtu1PmuyuivXsKNiKNIGsPDyVg5syUc
	w7RU0C8U7bMkARdY3Kcvyvq3f5M3Lqg1d0sjORDag7ylWcjh5M+sg4M7hLGu7KuJ4WgVgeOzkPt
	pv4b+npk7IfWerzR6+HKejD/NssZ6Bn/oX5g==
X-Google-Smtp-Source: AGHT+IHvZ7DVS9R7C0uR7/ESSCBO20xscG251oAVQCQVj4jvT3GvYy/BzbWJ4IBsZHUSyWpqWDJI+BneTq2LjzVg6Jw=
X-Received: by 2002:a17:902:fc46:b0:231:cb8e:472e with SMTP id
 d9443c01a7336-231de3b9eedmr348242115ad.46.1747904042215; Thu, 22 May 2025
 01:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520170656.2875753-1-krikku@gmail.com> <20250521085851.GQ365796@horms.kernel.org>
In-Reply-To: <20250521085851.GQ365796@horms.kernel.org>
From: Krishna Kumar <krikku@gmail.com>
Date: Thu, 22 May 2025 14:23:25 +0530
X-Gm-Features: AX0GCFv7gof8BoB4Ci3vKRuBaXy9gDGycYaSQ8C2QpMFxquFvGVwWqPO6FNr8hw
Message-ID: <CACLgkEYgaqhEONPwgXq6X6WFiA767qu-WdJ7OrXZm6CYE=qiJQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: ice: Perform accurate aRFS flow match
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, edumazet@google.com, 
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch, kuba@kernel.org, 
	pabeni@redhat.com, sridhar.samudrala@intel.com, ahmed.zaki@intel.com, 
	krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 2:28=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:

> Thanks for the updates, much appreciated.
>
> I don't think it is necessary to repost because of this, but for future
> reference, these days it is preferred to place change information, like
> that immediately above, below the scissors ("---"). That way it is visibl=
e
> to reviewers and appears in mailing list archives and so on.  But it is
> omitted from git history, as there the commit message is truncated at the
> scissors.
>
> > Fixes: 28bf26724fdb0 ("ice: Implement aRFS")
> > Signed-off-by: Krishna Kumar <krikku@gmail.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks, Simon, for your feedback and review.

Hi Paul, Ahmed,

I have uploaded all the scripts and a README describing the steps @
      https://github.com/kkumar-fk/community-net-scripts

Thanks,
- Krishna

