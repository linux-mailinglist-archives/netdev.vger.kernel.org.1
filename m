Return-Path: <netdev+bounces-213121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08F0B23CD7
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30123588254
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 23:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B6F2E9ED9;
	Tue, 12 Aug 2025 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Famjc7wo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67A2D4B6D
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042974; cv=none; b=lFeFPXpaUn+W4Dfm0QCsk/jl1ITpOpAx0QjzymjTNFlQ4Nnyz9e/1H+b0w/wEbRFtYkKHd9vtqsdcTY7qPAYPqL9lBsJFr+hzN4u/Jt+ixZOIUcDWCALcHky3zi6u1YM0/gp7QK61OLW7u2UEYMGe0vclLE9IRwVHDCtUjsIu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042974; c=relaxed/simple;
	bh=v+syHkhcFhm9vFNk3ATpbVfBTRDW7AKrcoVzaSSevZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEf7qfIuSB2XTGwp3ONc862a3BoZAfbGiTXbBS6QVl4BGhpcqjVA4Zap1iXJ9HGtNvBC4X7txm0kZJ+OZreziaPjsfxJbSzBSdPVrDKceEWa7p8cgSRWAO0Ryuxe5L6uv+ielUilKxJQmaeaWBSa0Lj9780bdwyoEPgfW2QxFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Famjc7wo; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55cd07a28e0so4381e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 16:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755042970; x=1755647770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+syHkhcFhm9vFNk3ATpbVfBTRDW7AKrcoVzaSSevZ8=;
        b=Famjc7wojYybrkb13PdVsT1K/ocYFTGmekOa79lOZQKkvLeO5Cmu791Yh+WhAod0F4
         75p5lLOUzMONP4fbjlpU+VbEeTaeMc6mfdpjDF2SUr4zSd3Y+z+mjjIMRZQSV3Chd+W5
         0g9nHUcUsIoLnMlix/gCgveW2T7sLKY813J8wIHKT9uQ3spvP4ZDX+S/2KNMyOAVGVoy
         0BeuSGafNdvgUqObX5T8GvmVvy9zxK2JLUwk3arU1LSDfnx/7mm5nQUiF4boCTlTjmBc
         Bwu/t7BvnBeaeUWYt6ivMZAe1F/BJm9O9OZph+DbuXHOA2y93ly9Mm48HvNhZcTerL8/
         aYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755042970; x=1755647770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+syHkhcFhm9vFNk3ATpbVfBTRDW7AKrcoVzaSSevZ8=;
        b=gW6p4L5b+I6PjwYz5IgmcFwLIYMX8c3ocg6RiqckylUqcqMtGQe40rs6biimbbsj70
         LC/wRdv/hl/FJ9s8xn9sxBRwH2uiTgOVC7nTWg3XdasyXNZcVbt/C0hdxwFP1wYDOktM
         MQjIFHN2wBwe4n0noBwkgaoPm3JyCBROw90EFHyDEFdIZPCbjW0mdHCWyvqq2IJFSyf6
         avIL+zTnWF+3lv5rH02ms1OMUbmEaEJjHjCHDZgK17ft03cAJTkYmD49n8vTDzsYVMzL
         z1KZLT8UDaX/A7v2mxjm6OUZmwifgJ8Hk6orzgh/LR3xOffD8Ou7ULBReB6U5qhuqtUV
         u8sg==
X-Gm-Message-State: AOJu0Yya4d4IdWPCzMW0pqm6NkWpI4JAfbwyygOt5PFEJcJtGUO5Dtgs
	Rco0oy75UxfTFysK2og3quY/w0nipv7gvc3M0BJm0rn7Xyzz+F189AhLC0tiEpMnjhZuia5wak4
	IuxBqaSby3UTWYo6SFgCTEwylwQoh5Eio1zzACmj+
X-Gm-Gg: ASbGncuShol2cHhwYK93Lvoxh97UFML0VxmeTDVN1/fxLAXdveNRPm+e/ms3fjCvSKr
	pF3kXNJOQK5qhO7eReCJsOZE3uHpYIWJ9Y3sYWs8UpfaC+X5N5YCAEzK5EsGpdp16u9SuiI3ran
	jMYud/D63gK1fCMMO+ErusFoFNi6/AUC3dZug9Gq8EA7Iu/B9vwE0tfrIAOrCtusut2q/Mf383O
	11UMi3yamDXqJCLGM5VLn50MkCgaStuLO08lFMfDOOVPjA=
X-Google-Smtp-Source: AGHT+IG7BADE1oIMoMkiTnMB02U7oegvgie/pz5P+lANc7v0ZsguFJ7pHvSqP/ZfpQND/iqeqZt8JxMFiUHCvaW+Dco=
X-Received: by 2002:a05:6512:134d:b0:55b:5e22:dfb2 with SMTP id
 2adb3069b0e04-55ce049e2acmr176659e87.0.1755042969766; Tue, 12 Aug 2025
 16:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754929026.git.asml.silence@gmail.com> <a85b5aeab5f011742657a9caae22da5bcdcf91b1.1754929026.git.asml.silence@gmail.com>
In-Reply-To: <a85b5aeab5f011742657a9caae22da5bcdcf91b1.1754929026.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 16:55:57 -0700
X-Gm-Features: Ac12FXzSVp3EfG3ylioy5fQmrSNhWvCwsCm03EQ0Oz8VefSzoKtOYqaSObFNVNM
Message-ID: <CAHS8izPgGe_hz1p7eHwSfLObbFvQsxM=iH+Ur6pVggrJ7pTC9A@mail.gmail.com>
Subject: Re: [RFC net-next v1 1/6] net: move pp_page_to_nmdesc()
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, 
	sdf@fomichev.me, dw@davidwei.uk, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Byungchul Park <byungchul@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 9:28=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> A preparation patch moving pp_page_to_nmdesc() up in the header file and
> no other changes otherwise. It reduces cluttering from the following
> patch.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>


Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

