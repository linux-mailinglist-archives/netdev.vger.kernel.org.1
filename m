Return-Path: <netdev+bounces-231370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6430EBF7F83
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 948ED4FB929
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A8934E745;
	Tue, 21 Oct 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j6QYjbUs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E034D4E0
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069075; cv=none; b=fikbHNM6ZPJSAvmc34N3OkD3Rmi9WKF7tv9L35at/4DWJSap+oFWgXbiUQtJLMvjExATrF7Zzn38AROLvp9CfWuTp0FPJtt19JD8MkfgqSNb7Mis5LqFgCDCqcCpObtMuJl1hwyLnLMJwzOuQncpzQ4ZM0YIU0Qzd8mfKk7NQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069075; c=relaxed/simple;
	bh=uulynMXpJ8L7oZoo/JnalEEKQQI90SdeVbLT2Q7OUmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJvhbljGtcS9gNepHhGpBztwp4/TwJ/hUNplOVdJmLUb+UHylRbjJTVK4F2EeIdMzsZ+DJ7zDtRvJFJU8rKsoxNPJrumgEnlgIzAPGon9Vi9SDvdgBpNCzxtHbPf48XC1wNynh21Vf/DAeOsznRy8M2INwtWywAPk6qOBPtCFjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=j6QYjbUs; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c2d72582cso7493736a12.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761069071; x=1761673871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeBYLR+HPAzqZm44zT70Xofjp77IUs91RxgARCWm0c0=;
        b=j6QYjbUsWWY/F8CWhjCzVdJc60A0qtVsOBjfWmSmypcAAxLr12SLg7D7BoBBOBqtoQ
         pCbgi21j4D0bivuS0Ba2Dw4XUKwCm9sWtlMT2auBpeengknFAqjmsOcM7mHPJFM/zR+i
         OM2DpD3/bALZfw4GfxVox0988AyDYtah6YReC2SdIIvSrf0scDESWHGTqQzoAgkUc/JB
         Hq95hidTl01xI1HtAaH6K5bWea0M3y3NLtEZvJiHRPYJMpr14jFahZwY6I5+k9fQg3IE
         u8WGhNyxUOXsFBkbepIRrrqkWN9AaMMyKmWCv4MvuH9dFm+9sxImt8CKZN0sgso9hiSB
         mkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761069071; x=1761673871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeBYLR+HPAzqZm44zT70Xofjp77IUs91RxgARCWm0c0=;
        b=niCX9uW+DKFGC2pK21R32BHNT9eoJnyu5bwqQy05Nw6IhV7m1khaZfwBp56pEu906X
         omLtHkDfe4l2fNyEC7bU+QaTrwf3maDngOF8pz1AG1VNPvAbeY5lZgtU3QANN8gt7haQ
         qVFVQCvJAe9EmPfap3IUGfijE/7Qeh4+wouV4DVMvrs4KsZE2qRN1EyESh7qoSAAUl9M
         FB6vJh4esLJ0l9FBmRyj7WjBOWXACYUISjybD0zGUDSgN8HUFgA/voFfCjNzrM1/DYwe
         Df+YrPyZ6KXC5sHBVutpZDR22eqoHm2l9VezXb6oeCLzrefRdKd4Z9te+mlPHKhi+Sh1
         76oQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2AZp1fbLMrPgVO68Q+rJvLqjRx4mFlQokpN7D4xXFxbhWh7PS33wAxfv81ueFYMV0bTo5Rtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHqLOh8VJh4V/7z6tlpiWVnoJJz2/17jLJTKJYJqmRoAaNWdW
	kxAapcqSo0gQLuzsIikPN+GGYI2sMKUQYCuZhLjXc2yGoZxsAEa3gIG1
X-Gm-Gg: ASbGncsCOCx50M66sd7a4g542zj9CuG5F1bLoMAfwnTromGjwhEoqcCom0QSx6FDRMY
	WkXkv0ijpvCyUjcHWOdq/A7PlD6ex3ZGRMod5Ye24IwawA2yxjV9h7TmGnIqpVR8cw+F2nW8zAH
	Xk5VYOMVLPJpPP1Brt0RNKqfk3vXntcicEKENpBT/N0WpMH8XjR9mLrY2iTZUtC5jYc1Uc23Gnj
	WfhWG7HOWODfGXijPr6ooRy5qYO+F6MFQl6bpiwI2dMHzm6cKlJhI+Ui7FQZ7ENohSlmICqY9T5
	YPtuiqASdcMLlNdPE+Iaz7C/Jh3N0g075y4HzusoWqnV1gEKs4AnlzwzhZge85+LQr0aTIaCl9S
	nc5C9w/t0nqmONK/CBCR8wOgLJ/L5+tXCM3PZbsK+lJQ1FYJaHJ+fTZJipqxVv5A45Q67Njme
X-Google-Smtp-Source: AGHT+IHrpAt0rLjva+P5xvD3NT/keHv+NO8Cp9/2lCGhGrs48scqdgskaOvuSk1U3f7LeXkeOhT2xw==
X-Received: by 2002:a05:6402:510f:b0:63c:20a3:70ab with SMTP id 4fb4d7f45d1cf-63c20a37123mr16345212a12.18.1761069071389;
        Tue, 21 Oct 2025 10:51:11 -0700 (PDT)
Received: from hp-kozhuh ([2a01:5a8:304:48d5::100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab52b6sm10017556a12.10.2025.10.21.10.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:51:10 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Tue, 21 Oct 2025 20:50:03 +0300
From: Zahari Doychev <zahari.doychev@linux.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com, ast@fiberby.net, 
	matttbe@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	johannes@sipsolutions.net
Subject: Re: [PATCH 4/4] tools: ynl: add start-index property for indexed
 arrays
Message-ID: <75gog4sxd6oommzndamgddjbz3jrrrpbmnd4rhxg4khjg3rnnp@tlciirwh5cig>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
 <20251018151737.365485-5-zahari.doychev@linux.com>
 <20251020163221.2c8347ea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020163221.2c8347ea@kernel.org>

On Mon, Oct 20, 2025 at 04:32:21PM -0700, Jakub Kicinski wrote:
> On Sat, 18 Oct 2025 17:17:37 +0200 Zahari Doychev wrote:
> > The Linux tc actions expect that the action order starts from index
> > one. To accommodate this, add a start-index property to the ynl spec
> > for indexed arrays. This property allows the starting index to be
> > specified, ensuring compatibility with consumers that require a
> > non-zero-based index.
> > 
> > For example if we have "start_index = 1" then we get the following
> > diff.
> > 
> >  		ynl_attr_put_str(nlh, TCA_FLOWER_INDEV, obj->indev);
> >  	array = ynl_attr_nest_start(nlh, TCA_FLOWER_ACT);
> >  	for (i = 0; i < obj->_count.act; i++)
> > -		tc_act_attrs_put(nlh, i, &obj->act[i]);
> > +		tc_act_attrs_put(nlh, i + 1, &obj->act[i]);
> >  	ynl_attr_nest_end(nlh, array);
> 
> The first one is just silently skipped by the kernel right?

yes, and then only the second action is being confiugred. The
index defines the action order and the expectation is that they
start from order 1.

> 
> We need to be selective about what API stupidity we try to
> cover up in YNL. Otherwise the specs will be unmanageably complex.
> IMO this one should be a comment in the spec explaining that action
> 0 is ignore and that's it.
> 

I am not sure if this applies for all cases of indexed arrays. For sure
it applies for the tc_act_attrs case but I need to check the rest again.

Do you think it would be fine to start from 1 for all indexed arrays?


