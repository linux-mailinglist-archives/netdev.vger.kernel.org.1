Return-Path: <netdev+bounces-242384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C816C8FFE3
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DB5D4E06EA
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 19:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC12EDD4F;
	Thu, 27 Nov 2025 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJYnFV+1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A83283121
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270555; cv=none; b=RWTI6BaJjkzjYN+xieMCcy1D0Ja/q00dc3AHsqM7s2cwQr6683ZLr2mhO8NPOTVjg0NHGEJeXE8+Xv/VDrhuktwSyIjUWiGq6yy0trsMzVpeAb3XlRzXs63sll3DstUlXdN+N/m9YGQ5XQd4nEjhILzpb7/R2l6A2JU3FA3lXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270555; c=relaxed/simple;
	bh=gP0gJdYtNZBdtfX/jK6MkOSRmxkDMYO6bpL6nkMzxfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aY8W+GD5lKhNsb6iKsv9l1/hyw/q/hh+wLs11LEdNVl0hV72/fkIdJYoaGPu1sDy2PLdQTzdUu1/TET2KBCaKtc779kpTbOm33of6zLpiYSENiYY1lP/VlJt9NyHBjH7qR87dn0ZRTitEKcDdlwd9U2x1kAVLRnyliL8Xm4vAe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJYnFV+1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-343ea89896eso1084417a91.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 11:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764270553; x=1764875353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OY5jIlyBQ0PQwdvHGR+jAPQ6+8q1xallDdJ1CcWtbBM=;
        b=gJYnFV+1eSrE7qNE8OrpC0VPwOZD8mfTb6bX0vwYB5LsXlv+6/5giEx9v/uLZg7jjb
         qo+8LsYp2mDtu+ZawoVNRQXoRGcSXNS4MbtGgfW5LvYa9w1VWtRIDF4lyIyc+xFWu9gY
         Kdq/kzxVOEecbLATUeidPLnumkqZI7yXjAcm1cUDOKc/lHlqBkSCfC69Jxf6qWiAklmT
         9Hf4JyydnA5nsSHL9zJA+LDRrTSk+O9CqsIVwmkPwNZLJmUUumwHgcAdX5cklGlFFdAW
         uspVwexzMlSRvp0nycqpOZqeODP8M5xozjU3GYn2HGjIHHtz+CHvlaRfsIdRFdE7vmGM
         jFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764270553; x=1764875353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY5jIlyBQ0PQwdvHGR+jAPQ6+8q1xallDdJ1CcWtbBM=;
        b=TVb35F7q9q4o5GCWWAIjWSb8RXz/J3kcyBmsh8Ye+M/NaIuqBaOHQu3SSp4p8aUUjr
         33col5SgxPESCW6js7dN+R7EEMuuEhu0U0bs8k7jvkeOAamebDgWYHSsvhUmIP/qpgEA
         A1Zv7++0q9fG1QRHmLyXNhodSBZ0wzVsMRr2Yka9Funwpfl6AtBmZIIFEeLC4dR2tV2W
         XLGBXPONKrwkYDEV4CHHE99Y28sO3so3TKb/zubixRnRFuh/7MPOudcmTpVdOvKsD9fm
         mRZlFk7DnTcsZqY7s8hcVgCpaXtsL6Iv627nAzOhGA2XNERKa7MrAzdCS9zo1H1mdkni
         qJ4g==
X-Forwarded-Encrypted: i=1; AJvYcCVWTee8fc+YEcunuIstNj0Vl3t2ZftOWX2sVrFndZXYrrNGssrXo2YatgF2ZGoD5qHcCxBmrKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfEaEX+a5ijkWhP0uDZLLHRTRMok0qP/n7rWMaWFHes4BcBTKK
	EyKn3Nk3jYxS6Cl8pbA9N12CAw1htOvbulvujXWqDk+B8zvkfmIeOdjq
X-Gm-Gg: ASbGncuPbmJxg3I7zIZtj+gGKesguX7clt02x6M3eq296FdpcT7ToobveLZdFvZJG4X
	YhTItNWYMMRh6v+RRmRwMIHzjDtP9oyDRqX0GiYwFY0rSpDaWWdQSUWjh+Bj7bfpRiOqAdXxXhb
	35YFe0xC4v9hN2ArkmkEDIZ4JNW1bRR8PpGLE8DPTp3FxEHg2FnepN7iquBdWmI4GvoJkixrTnY
	OzgSd4AIlEvZ0Yv5JihM0gJkW7c74vb+3byBdtPsRzCdYTHQ/1QB5z+C1EkRRKJ0Et+URdd1spz
	SaBqjC+j4L1o0CCoNEkppjL1on5Z7TUweJn0SQk+mc2x24nzN5utvtGkjlwqg7y9HIJ0sVA3+iS
	jsHidVnj+fKgf9W7rCxwpCIdgqGdlBnJME8VmZpfpQv/Rqr5zCvEZnVD/6QSwLER05l749ECYMC
	D8AD1k1ZwBtzPrb+0X8g==
X-Google-Smtp-Source: AGHT+IH+vRC9zTLeYw0xBCilcBEXZVVGx3x1L/qzyQ3WxEct7yInNWgFp+Xf3mZXk3iE/LqGUFaPAQ==
X-Received: by 2002:a17:90b:5703:b0:341:88ba:bdd9 with SMTP id 98e67ed59e1d1-34733f225bemr20332501a91.25.1764270552639;
        Thu, 27 Nov 2025 11:09:12 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:ef22:445e:1e79:6b9a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a55ed00sm6349589a91.5.2025.11.27.11.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 11:09:12 -0800 (PST)
Date: Thu, 27 Nov 2025 11:09:11 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
	horms@kernel.org, stephen@networkplumber.org,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3] net/sched: Introduce qdisc quirk_chk op
Message-ID: <aSih15MrrRud2qho@pop-os.localdomain>
References: <20251127164935.572746-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127164935.572746-1-victor@mojatatu.com>

On Thu, Nov 27, 2025 at 01:49:35PM -0300, Victor Nogueira wrote:
> There is a pattern of bugs that end up creating UAFs or null ptr derefs.
> The majority of these bugs follow the formula below:
> a) create a nonsense hierarchy of qdiscs which has no practical value,
> b) start sending packets
> Optional c) netlink cmds to change hierarchy some more; It's more fun if
> you can get packets stuck - the formula in this case includes non
> work-conserving qdiscs somewhere in the hierarchy
> Optional d dependent on c) send more packets
> e) profit
> 
> Current init/change qdisc APIs are localised to validate only within the
> constraint of a single qdisc. So catching #a or #c is a challenge. Our
> policy, when said bugs are presented, is to "make it work" by modifying
> generally used data structures and code, but these come at the expense of
> adding special checks for corner cases which are nonsensical to begin with.
> 
> The goal of this patchset is to create an equivalent to PCI quirks, which
> will catch nonsensical hierarchies in #a and #c and reject such a config.
> 
> With that in mind, we are proposing the addition of a new qdisc op
> (quirk_chk). We introduce, as a first example, the quirk_chk op to netem.
> Its purpose here is to validate whether the user is attempting to add
> nested netem duplicates in the same qdisc tree branch which will be
> forbidden.

As I already explained in your v2, this does not justify the ugliness of
the code. It was wrong to introduce the ugly checks from the very
beginning, therefore, it makes no sense to keep adding more ugly code to
fix it. Reverting it is the best option, as far as I can see.

> 
> Here is an example that should now work:

Oh, I am glad to see you and your boss finally acknowledge breaking
users. :)

> 
> DEV="eth0"
> NUM_QUEUES=4
> DUPLICATE_PERCENT="5%"
> 
> tc qdisc del dev $DEV root > /dev/null 2>&1
> tc qdisc add dev $DEV root handle 1: mq
> 
> for i in $(seq 1 $NUM_QUEUES); do
>     HANDLE_ID=$((i * 10))
>     PARENT_ID="1:$i"
>     tc qdisc add dev $DEV parent $PARENT_ID handle \
>         ${HANDLE_ID}: netem duplicate $DUPLICATE_PERCENT
> done

Looks identical to Ji'Soo's report:
https://bugzilla.kernel.org/show_bug.cgi?id=220774#c0

without crediting Ji-Soo... What's wrong with crediting reporters fairly?

> 
> Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Nacked-by: Cong Wang <xiyou.wangcong@gmail.com>

Note: My response is just for record purpose, I have to reject it for record
because I don't want to get blamed for being disrespectful to our users.
This does not aim to stop you and your boss pushing your agenda in the open
source community. And you don't need to respond against your boss' will, this is
perfectly understood. I will bring this up for other maintainers at LPC, since
I care about the open source community. Let record speak.

Hope this makes sense to you. If there is anything I could help you,
please don't hesitate to reach out to me directly at any time.

Regards,
Cong Wang

