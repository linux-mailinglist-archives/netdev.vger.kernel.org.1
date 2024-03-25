Return-Path: <netdev+bounces-81819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC5B88B307
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853FA1F2C26A
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5226FE11;
	Mon, 25 Mar 2024 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahLc+KHL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C16F085
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403112; cv=none; b=S0ezR1f/vfoYQhquPbVU6h7lngbCOvCraOduZfKW6lZm7WwpiSqiIVTQlmjZfKzm5ZZQIw5FQ2urZ4lrNHD3sIL90t7kVoLR7rYn5PXIYzL4r4e2NzHMli2jQmtbjMvLHUZSgAcZ6MWv0L/kkpWAVSkTJGZLsiwZp5ymcxKItlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403112; c=relaxed/simple;
	bh=dDHqG7cyGIqxwGd61GXG9jbFGtA/ejZsZ+y0aGUjYeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQFeG9sE7x5SEygJo2oZCr+Cg4Nx/3jVu25r8rAb/SUBoPAGw7yeXswcJpp1cHXUB4ObYtID7OHFC+s4ElXuRnGDovMIHnqlc8KJ2sLUyHp1uAzWYwLuJ0Ngkxa6QiDyL7Nf8gJ1wYPNdzh5SoIXJxPqfWBfWT1sIH9k4RqOnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahLc+KHL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4148c72db39so3521315e9.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711403108; x=1712007908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym+3+iAmVDfvw2iSJgOwfbEWZypO18/KuZnI7fMK36E=;
        b=ahLc+KHLc3jkfZZcmzDUq6+nzxgVVnzf2Ra+LmZEdOg47Zskj58/yKfCd+05aDppDC
         3qZ2FLUWVib2KRbNb6I67Qy+vMjWHzUpUtxbDwU8zRWE8TIpDfzkZ0jYbS9lrDYrzbAV
         SqkEV3h6Csmq92qXlJm2TX+fVD1oJV8RcgoroyrhgzYCzdN8OYW1nwenBZEsRKk1QBPD
         Rersk0S5W6Z9rr2Kr4sxRUkiD+SxPU4Xm1fmGqYj4x0+jaGB4TlYhWIqrkAKXggVsiMP
         jfHvbzpyQomxqSCKBJBFsa9X5y6IX3i/ys8YRQFM3CFpMaXz3v40sN3PqnoGzN/8hZ6E
         WQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711403108; x=1712007908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ym+3+iAmVDfvw2iSJgOwfbEWZypO18/KuZnI7fMK36E=;
        b=weibpcflfFkMrhCE9bpYqObAYQvkyy1vcGFqkIIIZzKV3MVJNbTfPK+2U8oYArq02n
         OR1p103yh4va+v+JR6hS41RZBwX90TAwsOd8t6//OiSt0WJ5lTkt2zxqOsLveVtp8dg7
         2SU8DbgDkScpcDtwqm02rUeQSovaiJ0F1UsxMmpxazCuyz8rjWanbI2KC39VH+vDMRVT
         RosgiH5OS8suJgqj9D6Wiq4FTltim4rN0VRYsf/nalxOc/CqMNmzrimaRKWsqusI5vZ9
         Xlghx2RMALdclXxZDDIvr7qfSIL1mdwyzgdLwYAfH/ofzVglsazs5d+L02wYvk9hxEVB
         Fb6w==
X-Gm-Message-State: AOJu0Yy8rNbe5DBXAJ2EEhp397zwgvSDizw6ZVTv43TiKhtz/T4Pvr6J
	e721i9w8cJjf/DFc3JPK0Seo4+59GJbhJIM2DilCVpPg9XefN91s0lRMpUtj3BM=
X-Google-Smtp-Source: AGHT+IGIhsBKUJ6iv7FuZPyMJH3iOgBrX8zonTymIJe2KUMrNFcDJcYFslvFD3qQBEE9EZ9tfDNq0A==
X-Received: by 2002:adf:cf01:0:b0:33e:c307:a00a with SMTP id o1-20020adfcf01000000b0033ec307a00amr5020495wrj.43.1711403108524;
        Mon, 25 Mar 2024 14:45:08 -0700 (PDT)
Received: from abode (89-138-235-214.bb.netvision.net.il. [89.138.235.214])
        by smtp.gmail.com with ESMTPSA id dv13-20020a0560000d8d00b0033e25c39ac3sm10437130wrb.80.2024.03.25.14.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:45:08 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:45:05 +0200
From: Yedaya <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: Re: [PATCH] ip: Make errors direct to "list" instead of "show"
Message-ID: <ZgHwYUtxrDP1Y+BS@abode>
References: <20240325204837.3010-1-yedaya.ka@gmail.com>
 <20240325141920.0fe4cb61@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325141920.0fe4cb61@hermes.local>

On Mon, Mar 25, 2024 at 02:19:20PM -0700, Stephen Hemminger wrote:
> On Mon, 25 Mar 2024 22:48:37 +0200
> Yedaya Katsman <yedaya.ka@gmail.com> wrote:
> 
> > The usage text and man pages only have "list" in them, but the errors
> > when using "ip ila list" and "ip addrlabel list" incorrectly direct to
> > running the "show" subcommand. Make them consistent by mentioning "list"
> > instead.
> > 
> > Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> That is because ip command treats "list" and "show" the same.
> Would it be better to do the same in all sub commands?
>
I'm not sure what else you're talking about changing, I couldn't find
anywhere where a "show" is referenced in output. Do you mean treating
"show" and "list" the same everywhere?

