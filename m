Return-Path: <netdev+bounces-199934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFD6AE2605
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 01:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1452C3BF264
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 23:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8C02405F9;
	Fri, 20 Jun 2025 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu10uKfw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5642A9D
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461646; cv=none; b=DpKHAhngesFpZtJEZeE85lDtQVal3JyAozrZGyBGS6MTtmrlFOLbWky83ZXmr9S95YN4vA5s5iAklFcIxOQmhcjCnjLqA4Kww9O3qziHnKEUZTXyAqXJ2DvD7xG4dpknHJowyp/0j3mZH7ZMraca2y7RXHMddRDHpS9xRJEc+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461646; c=relaxed/simple;
	bh=q67MiXmiAHVXXdA9lHd8hzICydmeplfosPkTBpzuamY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTDt4/VeFOAD8nRtSSUE92BOmYQ3mY0duC0N3pTOsXQ1JEkcKuQCkrLMtU2b6XC3AU6XSSuEF+iSPwKPNABISM9MWWF4GKo2GqgJY98QTA86e87nFyF0e41ac/gjgMYy851+QVxkxTi8uEDYOJORpNU6EzLQwt99ZeVbKH5Gd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu10uKfw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748a42f718aso2266627b3a.2
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 16:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750461645; x=1751066445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPsZQ7iGhk6b0DL12LJW2cPT2QwQ+eG4M6x0CeeFLK8=;
        b=mu10uKfwNixqidi23BGukUyzG3vxOCPERo2rTzkHhiSq22MVcWYl1j9yiVrJayV0Gf
         4qEKkRsdETE1gTh//7zC5ipzoX9+t7b1+qXP3iSS8hWWiSFanIjDP7Fsr00cMHIpGAVi
         dcfXuBQwFSt8dMD1sNJsOWarjPuP+3BLalWbsh8H2qfJfUZzYeeKD4M+ScV46LMK79R5
         PbXiQDfOqSXN11D7gZ9SssK/BT7D9YlaZ8IhBxlD3MTUP8H8Kx2jcJHgFp2cfdWFyDHt
         6onoToAqfCpQ5gFSfNNrXmBdS56jINmwHmRFnWIenRLaCv6oIEcOhgWmnvzkZaj9CmDp
         KTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750461645; x=1751066445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPsZQ7iGhk6b0DL12LJW2cPT2QwQ+eG4M6x0CeeFLK8=;
        b=cvTJeNpwV6IyL7fL22NkGGl4DObijokoee9tkAbiTiYLTJYdX3VGG+2Mv8rodmbzf0
         U7zKnc0vzzfzHOTp2Dsw56v/yIdIXr7x4OITO08y+Qxxuye8sQrlgqzcRsrIVpiojxi+
         p2PtloxUPhObIqe9HcROscidwKu1pso/A3blL4+7+fnp99YQZXG2MYdu80xNAfmtZFTX
         DC9QgK4L6anGPHI+YPz480Y6v/0NNLhjFgdHDaieC5aNEIPTzNIKruuV5DXzk1SNJKaQ
         8Jpt01XNJsQNptwu5OPSfS1G7Uvewxv6RFwLxAn5kH2HQOO1O9FgSzPoAnQUx59r4JrV
         SxNA==
X-Forwarded-Encrypted: i=1; AJvYcCUMQIKDX5F/StyICFzSzV1jau+sCSuLQK+eHfzUM3Yo7Bex3Z79Td4UZtcBYXjwR6fXz4bIBdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyadPQxW7kxzmN2JcFDi0B6nVkSNR5CR/9KfesUEej0TTuGNpwD
	7wUOEAuV6csMgobVVK/uemQ7uElk1wsp0Z0Y7AkVejocvTIxSybH9XU=
X-Gm-Gg: ASbGncvhj2gaolpCTsxCPpt1+B++BhXPEnbPrx0W5v03XxjKkYhFeonmeRgAjbCahWe
	tF3XeDVSyd9v+LoMy7VxVbKSvIPpWwJCkBQvusl7zIGVJntnOtSu5aY+sCWwwvtqLZtYeehtaI8
	glbR/lQs4xasydi4Z1ia5ilcWnMtn0T9nV3ex96BJi61M3C4bhNaBEm25mSNvjxNeKIF/GJ7PUc
	9lqa19Ts93dEQfvxq0Z+FojCtKvAhkBhmRTC9I9/7CfqaWPkml92XI+pkNXxloFgXYbrHV6Z93y
	7JBvvK3fR5tj2m08suFYJjvbO8jVA9Sn+vlq0Xbzo291Ag9P7xhprfRm4tNJFfH2XEwh+HJ1exe
	aWJf1IFj/Kl3DlDMeqN0ES0Q=
X-Google-Smtp-Source: AGHT+IFpVidDrStwVAyumaK5Q40uiMlyK2yl6lpIjMxsf1XiwLFvsFuU3YC2wl/iKFH2SrjnXg1aQA==
X-Received: by 2002:a05:6a00:2386:b0:748:e150:ac77 with SMTP id d2e1a72fcca58-7490d6c3b5fmr5858401b3a.22.1750461644579;
        Fri, 20 Jun 2025 16:20:44 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7490a46eb71sm2869686b3a.22.2025.06.20.16.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 16:20:43 -0700 (PDT)
Date: Fri, 20 Jun 2025 16:20:42 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Hillf Danton <hdanton@sina.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] team: replace team lock with rtnl lock
Message-ID: <aFXsyoJ1ZIULrC3w@mini-arch>
References: <d4047311-5644-4884-84c0-059bbb9e98ee@I-love.SAKURA.ne.jp>
 <20250521110024.64f5e422@kernel.org>
 <ec84752c-1e3d-413c-9c2b-6d83e48470ef@I-love.SAKURA.ne.jp>
 <ae7e9800-e395-4b9e-9878-83a5e768cc98@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae7e9800-e395-4b9e-9878-83a5e768cc98@I-love.SAKURA.ne.jp>

On 05/22, Tetsuo Handa wrote:
> On 2025/05/22 10:00, Tetsuo Handa wrote:
> > On 2025/05/22 3:00, Jakub Kicinski wrote:
> >> And as he pointed out this patch promptly generates all sort 
> >> of locking warnings, please test this properly.
> > 
> > I didn't get any compile-time warnings, and
> > https://lkml.kernel.org/r/682e6b1f.a00a0220.2a3337.0007.GAE@google.com didn't
> > get any run-time locking warnings.
> > 
> > What locking warnings did you get? Is there an automated testing environment
> > (like https://lkml.kernel.org/r/66a4b1a7.050a0220.12c792.8f9e@mx.google.com )
> > which I can use for testing this patch?
> > 
> 
> Ah, I got which posts you are referring to. I was failing to receive Jiri's mails
> because my spam filter setting was sending mails from .us domain to trash.
> Now I removed the .us entry.
> 
> 
> 
> Jiri Pirko wrote:
> > Sat, May 17, 2025 at 09:32:20AM +0200, penguin-kernel@I-love.SAKURA.ne.jp wrote:
> > 
> > [..]
> > 
> > >@@ -2319,13 +2301,12 @@ static struct team *team_nl_team_get(struct genl_info *info)
> > > 	}
> > > 
> > > 	team = netdev_priv(dev);
> > >-	mutex_lock(&team->lock);
> > > 	return team;
> > > }
> > 
> > 
> > Why do you think this is safe?
> > 
> > Rtnl is held only for set doit.
> 
> I assumed that the caller already held rtnl lock.
> 
> > 
> > 
> > > 
> > > static void team_nl_team_put(struct team *team)
> > > {
> > >-	mutex_unlock(&team->lock);
> > >+	ASSERT_RTNL();
> > 
> > Did you test this? How? Howcome you didn't hit this assertion?
> 
> Tests using syzbot's reproducer did not hit this assertion.
> 
> > 
> > 
> > > 	dev_put(team->dev);
> > > }
> > > 

[..]

> Anyway, we can't remove team lock. Too bad.

I was hoping to see another revision, but just noticed this part. Can
you share more on why we can't remove the team lock? I can try to
give it a stab if you're not planning to send a follow up...

