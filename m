Return-Path: <netdev+bounces-57506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B0F8133B2
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15DB282F0D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493405B5A5;
	Thu, 14 Dec 2023 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOEJlhmm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D5711D;
	Thu, 14 Dec 2023 06:56:24 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1e7971db2aso948176366b.3;
        Thu, 14 Dec 2023 06:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702565783; x=1703170583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwPvIr0iXoyea553Yu3So7ADX0ncA/Wo0qGLRHYq400=;
        b=YOEJlhmmZGz+dijPoeZ7kJF8aF1tvO1YOgg+qwoOm7cnO1mj0RZ964qsb50vYHQt4m
         wqBWKGNXy1k0bqNMbyhKSD4MAuG4QapLi6H4vHAnnaa9PU1OPB50iqAK9+xtsWZ1joh2
         l5SG+ZqyHdugTqkZvQvngiWY45PQE62/JKscKnwR+mM5oTzbkS8Z+vnEslMoHd5F7sS3
         6HQTJsO8fcB4smaMr7Wgn9IMi0LsmVHRxTUxQc0mtpkgoy7bjUU/7PXXuMjiU/IgbwM0
         27GyzF1aN4xBzJFv2Tq8uS0+bEliOZKyiSTLXJbP96Ynuctb8HBui6bRT9tnBCzB+hip
         dSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702565783; x=1703170583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwPvIr0iXoyea553Yu3So7ADX0ncA/Wo0qGLRHYq400=;
        b=cK9oTPWfOq1o64G1ISTZQFo82pXLCg43yhGKtmjdAfXC8FrlKOKG6CCckEgWehXjC8
         E68f6VBLgis/TBLKefT9Rpj2k1TbN1E1D1ljsVYCiTpU2VKOVIjT+XkeHxtCG3OtT6W3
         99tjmD0rdKeki+ifyzM1zHehw8k71H3kavEU/+0DYU3UEuuyOIPvzHK/CnQiqRydBXZa
         2D+SoBKABe1NobgUujr/Nmp046Jl0qb9LBXpETgdNEh0s/bma4jwwxinUnEAHGGxO/Zp
         mRsHp4RwitZSmaEWlAp3HD9X4OK8QVDibb+Yq/eO/VfyH7JliNJONwscN3TDDt1yd1Jc
         szNg==
X-Gm-Message-State: AOJu0Ywc1yXZyprfRy00t/6StT+lHIxCyX1QROLEnc98oJ0eJenMCm3m
	08ruk0cM7xY1dvoJTnFV26Q=
X-Google-Smtp-Source: AGHT+IGwNVdNk1I/FL//RVZE/axgFj+QbAHQGFURAQUOWUlrWCeWC6Bt/WMspN1uIWdFzxTm8gZBhg==
X-Received: by 2002:a17:906:2d2:b0:a1f:821a:11ae with SMTP id 18-20020a17090602d200b00a1f821a11aemr4910517ejk.20.1702565782883;
        Thu, 14 Dec 2023 06:56:22 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id mt29-20020a170907619d00b00a0a5a794575sm9515400ejc.216.2023.12.14.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:56:22 -0800 (PST)
Date: Thu, 14 Dec 2023 16:56:20 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: dsa: dont use generic selftest strings for
 custom selftests
Message-ID: <20231214145620.lfsft2c3x5fjz6ev@skbuf>
References: <20231214142511.rjbr2a726vlr57v4@skbuf>
 <20231214144751.1507-1-ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214144751.1507-1-ante.knezic@helmholz.de>

On Thu, Dec 14, 2023 at 03:47:51PM +0100, Ante Knezic wrote:
> Indeed I do have a custom implementation for the mv88e6xxx chip, but its not
> come to state to be posted because of test/chip specifics.
> 
> > I didn't notice when the selftest support was added that there is no
> > implementation in DSA drivers of custom ds->ops->self_test(). Adding
> > interfaces with no users is frowned upon, precisely because it doesn't
> > show the big picture.
> 
> I was not aware of this, I apologize. If this is the case, perhaps this patch
> should wait for the first custom self test implementation and be reposted as
> a part of bigger series.
> 
> Thanks,
> Ante
> 

I agree this should be resubmitted with a user of the API. Looking
forward to seeing it. Thanks for the understanding.

The only thing I would want to comment on the patch as it is is to avoid
the pattern of:

	if (a)
		return x;
	else
		return y;

and formulate it as:

	if (a)
		return x;

	return y;

instead. The "else" is redundant for an "if" that ends with a return statement.

---
pw-bot: changes-requested

