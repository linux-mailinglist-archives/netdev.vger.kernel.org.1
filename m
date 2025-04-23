Return-Path: <netdev+bounces-185097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1630CA987D9
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94791B65C96
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E181C1F3B83;
	Wed, 23 Apr 2025 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j98QR+QE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1B535D8
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745405353; cv=none; b=RTFFjkHr+K37ufGWpcs9J1XJUeD1uZr/QjoYGHA5f/7/C/BK55pK6WpEa0YtmdjelTlM+nqqSgoete3EirFumNos9FAoBG12eqhpqqYpk/DsujRRg2/se2U85K6Op/AcNVBVKAvrS6CjR34bOXaLo8+7pHKSS/musyXd4Op+XAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745405353; c=relaxed/simple;
	bh=V8+xPugxbf59QUYpWjznbJ8MifPS+zZA3BGeRoxDpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FodCbzLv06WJ89B5tctspXiBpHZ1MY0OWS8tjH0KtP7gV+jq2GAXe+xeK8oLgcmioS3ZvsWV2Oz6yPE3Qd3+uX98rGWxk/PqZFMV4INFJRSXmuW4Ms+zAW09cgeE+Qi/2+HXKb5f8DHKZ1mAAJaekGqbE6Lzsx4W5Yz0nPWO86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j98QR+QE; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7040ac93c29so59719637b3.3
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 03:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745405351; x=1746010151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V8+xPugxbf59QUYpWjznbJ8MifPS+zZA3BGeRoxDpBY=;
        b=j98QR+QEkwBz5VNThGhrpkb+eGt1unbvFVH252yIGgsKbUnkjvJXWB35Vwu1DpEGJT
         /IHCnqt/KgtZb1KAmKVQqN/3BrJz+jmLQj3iwsAOPr6LZkZkARO3GwtvRGxxC8qd0UK6
         dyzP4dmtCo13m6BQG3iNmk01O7FZLUxegKsqViyeHaJQGdbzf5Kx9SWSGmldKQcOpLE+
         osk1WfWn4qfY5umz/r0rOw6g/nt19l3VdxPn+bLuv+BOXzQfu+hBw1X7jCIUUxWqKJU7
         c6sGyIBzFDEhsc6DIuYKY+jOVWKB/fQjfM7HfCfbVKAq+JSa7s4luktH7hpANvYMIiVx
         qMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745405351; x=1746010151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8+xPugxbf59QUYpWjznbJ8MifPS+zZA3BGeRoxDpBY=;
        b=kwOuWKZ39setx0yYpGTFVlbkANLTOXjauNWH/Nj2QVPRbVwPTlBwaA8CWdSk0Ky6+A
         cu0+dOAlydnAdgjRCIbHhN9jYiV2JpopkRpkdTwgyChouyRDHH70/ZZc3OoWGpG9IQY+
         6ALbesZlt2o7BWT+j0fIBQJYh3+8WM07EkYOUhjdL4SUwn4nUP632BmRv4Ndq8P9uzs3
         /R0Wxu5EUVP5xMO72VtLiWoj6DCPf77nVTplO3gQW4Wc0qbb6VFk6EToLGTnLLsgld3v
         u+Jt1TMaoknp9zbea5ackipoI9XibnuUm3hPcEfgMkPcAJyk2kRI0MFBQm2IeJuEWFly
         1F1A==
X-Gm-Message-State: AOJu0Yyrl1R9YZ7GRcKC6HommPLiuT+xs8HgPsKIZqR/ZYO/OuHteZs9
	JCEHJ1xB78tDtxxVQyQKeuRX4t4SjSk1nML/PGkCJZYJBuKFL7f0ubIzokz+owCX/VTI/6WRByU
	5NrN7OZq9kLduJv6xZmPLcd87UaShNQ==
X-Gm-Gg: ASbGncuAMfz+D5pnHF8QxTCS+7AIwSOiHd41Am4eUTscDfiCvbNfFqlI5z2TZwu2TwO
	L0G4YAW8/MOBGdsi89RFxn7zfHAT9N+yHLKgP+NQLFEmSCKPes3xmG42IZ1ALQw3Vxq9GGehh7M
	WXryLxy6iUvynHJtrP7i4Clw==
X-Google-Smtp-Source: AGHT+IH08hFZuvJr20mYNZSxUwaDDZDlyimJAMXb9w7/6/9VyQHnW8lKTTHVplkPdZBttxEEfHsU7g2FdRapJGsOASo=
X-Received: by 2002:a05:6902:114f:b0:e5a:c837:a8c7 with SMTP id
 3f1490d57ef6-e7297dc5082mr28022882276.11.1745405351199; Wed, 23 Apr 2025
 03:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+Lg+WFYqXdNUJ2ZQ0=TY58T+Pyay4ONT=8z3LASQXSqN3A0VA@mail.gmail.com>
 <20250423060040-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250423060040-mutt-send-email-mst@kernel.org>
From: David George <dgeorgester@gmail.com>
Date: Wed, 23 Apr 2025 12:48:59 +0200
X-Gm-Features: ATxdqUEvhKlrEuVkmxKmUK6G0UBk1E-ICkqYcNvwd6HkwYOOrKzEMcYMCapfCrs
Message-ID: <CA+Lg+WFSwHD5UMC=vQRGm+x3oG69nDFkJqkbzJy61mOJ+VTteQ@mail.gmail.com>
Subject: Re: Supporting out of tree custom vhost target modules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"

Thanks for the response Michael.

And apologies for the earlier html content.

> See no good reason for that, that header is there so modules outside
> of vhost don't use it by mistake.

I suppose what I would really be suggesting is adding the possibility
of a driver outside of vhost/ being able to include _something_,
enough for it to implement its own vhost target. If you don't see this
as being useful outside of my use, or my case too narrow, then I
suppose there probably is no good reason.

Alternatively, what did you think of the suggestion of introducing a
mechanism of a custom backend for vhost_net? In principal it could
make the existing mechanism a little neater perhaps?

David

