Return-Path: <netdev+bounces-77448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 450CA871CE7
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D434EB254DC
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065FE54905;
	Tue,  5 Mar 2024 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHVRGyXw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE11C6AD
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636773; cv=none; b=Agw18oEEfQLRVo9EtAMb53rDM6X8Mf8ZDP8EY8CeVIMXh/wtz831nvS2179SVPgRVvVj6lLKMC0Rpl1ctG7Z3e9v0fIFLS/SXrmMI68wsS7ZHV8vPs6GTj/svJtEw6xRovunPQtaE2mHJL6YAiWrvgb+OwkOjAciXhr8KzYZheA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636773; c=relaxed/simple;
	bh=Jfp3hDb3y12yLg2CORjEmvgSDrOhbfQ6FcmGpYCLNeg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=JecBWX8t1CvRgXQh1CBBVusxHzN7azyQLJXdcuoueC7zr/xwG1p+BSSVxXNg1lmMAK1XvDiSyXinshJcQCwVHt6KtaMJi2DU6iKROV2qKiQGeqGNGz32tKdndmGnNqQ3U5UsKRpFafhmuQHSrNUYl+9BleHQGPy9rPo+EtzZsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHVRGyXw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33e2774bdc7so3268320f8f.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 03:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709636770; x=1710241570; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jfp3hDb3y12yLg2CORjEmvgSDrOhbfQ6FcmGpYCLNeg=;
        b=UHVRGyXwooCVINQXNLHzvVgk/wZyoYCG7bvcWRTbV4rzmBp2vsVvVcXCLUSgdxjJun
         hSSZ7eHrpiqFVueHwUIaXQQ25nNWG3ISKla01hjAg7Q0ASW7ceE+DDsWt8wBTUBFKSkO
         GooPBWUsHh7f48uyMjdiynZXJi1F25gHJjhs5FPFaAr37E6Kyy/rQViO4rfChfucSWQ7
         uz9kgc+U2/uMPgl2ui6HsnSIUci0E27HIOssWTz3L7TSsP5pUUOiO8d+HNPHtEsyHANY
         dDG2gq1kE3SRFs7TlGE0HMYNGusT3Z+aPLoq8haxuso/VnEZ8vVeDGY44++vERlk2okw
         70/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636770; x=1710241570;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jfp3hDb3y12yLg2CORjEmvgSDrOhbfQ6FcmGpYCLNeg=;
        b=MIUnJ8dkBN0lZbcocuc8BVZWYheWiQgZOtceJfkUW/I0jIoqFpj1K/70u8mvqD0q6e
         AL//2LbNFKzWvAcSeWUPe4gHpvLzewheL4uXxccUnmWUOYR0348wryTyvru7b+j5tTnZ
         wmKUGktqWhiGjqdZdyi8fFwaAjo3KqSJfbU5AADYGlmFnU4Bpl1l3ZF+/ZZj7D/64sT0
         0uY5S+Qq+TtWxrAI6nrzQrjBgSs4gk31O78v7EqNSm5qKdmqPHOdmpCCkytBf/TAGi4X
         LkaQmcjgI6HGINVwBQPsvgbOIh+OpBul4sImp+ueBwm9Ql/iz3UMOD5Y1gwLoTvaKkP5
         SOEw==
X-Forwarded-Encrypted: i=1; AJvYcCVVl66LyryzF3wQCHGaL9gUxuEgJWBrcJkjw5ZStuTAj+SxzLdp14oJcje6wKjWFS0830yMRYYIfaNVE7dzNbGfBeGGg/dD
X-Gm-Message-State: AOJu0YwKbe+cduDQyGIL0osGZj9qUQJmOW8mBnJPQV1yA9AUl8Ry62fO
	xt+PjXtYWjigzArIFxQed8CE+lQJltqpx8LZNFHYGbh59fMAg+Y/
X-Google-Smtp-Source: AGHT+IG/W9qOd0alw297FKzXfcBJO8lwFUHXToRVffWNnk+1JwhOgZlbeMm2cK1Pzggn5/FJ57Q3qA==
X-Received: by 2002:a5d:4389:0:b0:33e:34b7:895f with SMTP id i9-20020a5d4389000000b0033e34b7895fmr4071502wrq.24.1709636770588;
        Tue, 05 Mar 2024 03:06:10 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:554f:5337:ffae:a8cb])
        by smtp.gmail.com with ESMTPSA id m19-20020a056000181300b0033d3b8820f8sm14634916wrh.109.2024.03.05.03.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:06:10 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/3] tools: ynl: add distclean to .PHONY in
 all makefiles
In-Reply-To: <20240305051328.806892-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 4 Mar 2024 21:13:27 -0800")
Date: Tue, 05 Mar 2024 10:56:27 +0000
Message-ID: <m2msrdhrqc.fsf@gmail.com>
References: <20240305051328.806892-1-kuba@kernel.org>
	<20240305051328.806892-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Donald points out most YNL makefiles are missing distclean
> in .PHONY, even tho generated/Makefile does list it.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

