Return-Path: <netdev+bounces-123365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465AF9649E9
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782581C22352
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781781B2EEE;
	Thu, 29 Aug 2024 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="meiDYu5T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FEF1B29CB
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944994; cv=none; b=fe8MaJBUwGlpCRGJ/UN7rsCI7JcPYzDkGKBqgSFxHoMJvSavytiQkHxsWD7HCxZWB1Bh9H3FHgs1KsQkyYoUWQk2b4VPbMhwEnZZH0sudPGiVq3gNmb9fD5vlmakh4Fc1HAqQ3tObQbybzlPYsoaoJGoyeRC116gDlSjGAQaQgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944994; c=relaxed/simple;
	bh=3eiFbN5nzjKu4yzFtXfz2GIM1Xl+U/uh2MOzzyJsOaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liD18J69Amj9cFxyGcbLslcXX/uZaL0ga8aN8lU30bBi/IFfkxr9cuWAV3ErlUHN9Ij68lxx+8DEReNvX8Ot5iiSvlc03Qe597m1vSSMhgwhU1npRpyvLEn6tN2QX/Ua2n4VSphfK70JbSpKb87iClCzusu2jO7dFfprle15yH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=meiDYu5T; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c0a9f2b967so915802a12.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724944991; x=1725549791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eiFbN5nzjKu4yzFtXfz2GIM1Xl+U/uh2MOzzyJsOaY=;
        b=meiDYu5TEe+P8y2IQC7Lo8O1HQaR5IUunO2qiurUO/sYEFN5eW1ZsPZ47ptL/SCHI2
         tDqofUOTJNMUWxRcgzKO7jGidIfnvD/gN8zcB15G7qZ4ZL+7Lg/hLHaKcGdnDIy/vIIJ
         DK66eB4q5g2hrAnfOcU1qvQFbtfadBCGsltia1xmZgiiLYQopcu+s+MhnhXQSASd6VH7
         m8EQHfVfP6HRtedjqvHwAsK2lTwZ7wruc/hJHJLL7bt34MeiuUCStsrGA+62shChHI6y
         yKKUMADIf5eBcuzo1W/vJ0X1q33Pg2Ln198MaqxeuT79sIaMyrIImm83PPTZ1S0AgiB4
         JbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944991; x=1725549791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eiFbN5nzjKu4yzFtXfz2GIM1Xl+U/uh2MOzzyJsOaY=;
        b=Xys0tVjBjzGp/XXdCIw1ptRXtpTFmzuavAzPnwQ9br7Jq9ebK2m5LlmjoRZyVAbfnE
         Fv3oVe+enb6LOudy8JTyfyVg5UZ+TLJwnFbqnHhvR9az0v1ZLYBxtNUz3WJ66K7QDTmC
         oXwQyBQr8H6zM6Ks/tVPw+yeWK1BA3B5HgCYlCMTCjp9zUocLIR3HpReiFTXr5TEGWNg
         QPYDtBvl7EXfO5wO/URSUc+QCZ2Pz2F293SBY2X/T720CHNt08q2eHiHhicVEwiPYS9Q
         s8JKG0SroflhFcAyqDV3VzI2bIWAHlR/MFCyH2EVsEPHsoj94UAVZbTd0PVx+vImtAoY
         mzbg==
X-Forwarded-Encrypted: i=1; AJvYcCUFT10ePAZppQAh5AHjK+gaR3BG4J693IpmmQwuIonNsg7fEuQLP9dZM4yZKrfWn5rpFg/oDug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFLSS3dUBzqhVCZZMpQNBiU57Tz3JJfnYn+u6/tWxx4FzW3F5O
	ZcRIsiFxsfYd96VVDk974MR6awPrSrWjb3iTV/0RSNe6qLWqTcwVX+oQwyF0SBrGIe1k+W5wVJU
	4bDjkg8ur0WHOU8k5W+uhhkq6tkD/BqtiOl2FVKtukCO7h/Qv4w==
X-Google-Smtp-Source: AGHT+IGSbtS6/CWk7vGWKdV4Q6cqHzpkgdgaZWeC2y6HTP25EM/sj5jOpfnYqyUkdqMAjsAWDx2GtnP63g3oDmXNJog=
X-Received: by 2002:a17:906:6a18:b0:a7a:9144:e24c with SMTP id
 a640c23a62f3a-a897f79aec6mr245337266b.9.1724944990245; Thu, 29 Aug 2024
 08:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829152025.3203577-1-kuba@kernel.org>
In-Reply-To: <20240829152025.3203577-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Aug 2024 17:22:59 +0200
Message-ID: <CANn89iLEh15ZfiCZtjtayTUdYYgne340_nNQ_znyua5ngjjEDA@mail.gmail.com>
Subject: Re: [PATCH net] docs: netdev: document guidance on cleanup.h
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew@lunn.ch, corbet@lwn.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Document what was discussed multiple times on list and various
> virtual / in-person conversations. guard() being okay in functions
> <=3D 20 LoC is my own invention. If the function is trivial it should
> be fine, but feel free to disagree :)
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

+2

Reviewed-by: Eric Dumazet <edumazet@google.com>

