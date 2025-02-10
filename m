Return-Path: <netdev+bounces-164709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D69A2ECA6
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E401612E1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199BF14B08C;
	Mon, 10 Feb 2025 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bghmlNOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5514828E7
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191029; cv=none; b=Uoj9ue5vgPbfvEr3sma0Aw5bEWbA3L9Y/jsu1ZgWfIX3BFfy5303W1Kk9Bm09XVgdkGST8wtRX3/01+J+0RiZR5o69mBoLTA2K/Tynx42m6fcpoUI861khqXRkB+RHl9ufIVjDBIlmo2fqHVLxGVgF7J3AnUJm5efWhisOG4LS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191029; c=relaxed/simple;
	bh=K3MtQ5idC4oHoXTcpqKWeJSzAGrhCwaVTOUqmUG9xiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXczD9bUHW7jalY66icOaJiwIchW92zgbW41NtwpyJmoYmavKOysygxMJa+kcvU/1zXOWzLOZgxhBoVWhDdCRpCW7A/lFto1eocF3Nma/Z9Hn5SrCFHxJmR4HwKTznXd/SE/XVk5BpnCAmfPoBHblp78P1pUqvNBojOT0Yya8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bghmlNOb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434f398a171so3928965e9.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 04:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739191025; x=1739795825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3MtQ5idC4oHoXTcpqKWeJSzAGrhCwaVTOUqmUG9xiY=;
        b=bghmlNObN4ngLaKGYGifhki0vjqAhhBtQLPKG5Ts6GOhft0r+A0O9xOk549qy4+E7B
         LR5rBfB6zWjfwI1C4makZRLzgkjsZBUujlXI+K9+atoZSWywuWzsV55O9i/mxv5rEv0y
         EyDaV0jI88qaSuClu2Nj93lShYgiWsOgpny2Sio4/TR5T8fKDhubOx4SZ06i16FkdSaq
         A5VmG/75jaDt7/07OkPm4qh2AndIopipT6fCNnpvpWF5j3pEnDJWgsc68QF4PrsK3t3w
         dF9eXYA/5TZ2VQM/Lk+LA+dfrbDBCGIGVNCr7PdMpw7uj8aOtJrMOIE3FNptbhTpWBW/
         vehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739191025; x=1739795825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3MtQ5idC4oHoXTcpqKWeJSzAGrhCwaVTOUqmUG9xiY=;
        b=DGYnK9JpUFCo5F6McvwbOgMWn3UJm3lyZ2QdeMVi9OQn4uHQ+kLMZpq/4EK3O7HtIu
         jDp3cw1LLTwkDWXYFHbgC4rzI/IP0hE1ZqFyYRvGudkRAs4Z4VT5s/JYazOex/282Qu5
         f7ZG661tsB4teVDRLp3euqLqy6JLUuspBgdfHYi/8rITX5FDhwBH/RwsysGVxa0qFDgN
         DgA0g3aOrpLdJLixYtbFW87ahdwFta0wJe0urrMHMUMNGAFjoK17larpo7nb0q5ZQsSL
         EMfqywZr3/LmPrsnIbx1PNo7o8piK85Wod4wEmguF15ewH4WStqMHBYEQy5LzyFdzlhu
         tVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwkCSIWaLA7TmvxZxaECkIJDukdToQQ/YYD2+JI/3n9+WRJ+18a+QdwQDNHq5UW9HFRVoAqYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcqoRFROee6w3IwJzpA8lO1fZw/YYBCkm74nfkP28+QS64E/JT
	7oeAu25BKtJk1AhkgRQI96cFsRjvGvK/41YfbI9dIgC1FwPixdhe
X-Gm-Gg: ASbGncv9Zrli64aqMFwrbFfVoswmmhDgthxEecdQCoDo6lkovAcUIg2GDiQaatf8zns
	OoFpuAGkEzfgg6CeGmR3Bz9iqBcRy+mGN09r/llVaU5QSCCxZxXpGdgmzWCh5romQd+sh0WL6+M
	IrMUXHbopDckTbsb8R3UnNYPOU9PJEk1XvCgBWGcTMCY5ua4xV6rnTUq3sM4Qx0v/ZM5PjjI/OH
	xkL892p5Q8F1xLbr57IizzVJmM8NhAzOflbZUSkByf04SHcyIzUegem74d4K1Rqs5tzJmrptHyD
	s08=
X-Google-Smtp-Source: AGHT+IFp/qrMqpF0QewcGTK19D8rZ6WhmzABzEYZiO2aWnKT/+1DEN2GE0Y0xC2bvfjR6EFR1vJt5w==
X-Received: by 2002:a05:600c:3b24:b0:434:a0fd:95d0 with SMTP id 5b1f17b1804b1-439249af823mr44302995e9.4.1739191025313;
        Mon, 10 Feb 2025 04:37:05 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd34f2af5sm7073731f8f.78.2025.02.10.04.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 04:37:04 -0800 (PST)
Date: Mon, 10 Feb 2025 14:37:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 2/3] net: dsa: allow use of phylink managed
 EEE support
Message-ID: <20250210123701.7gdt56l5m6t5c6ge@skbuf>
References: <Z6YF4o0ED0KLqYS9@shell.armlinux.org.uk>
 <E1tgO70-003ilF-1x@rmk-PC.armlinux.org.uk>
 <20250207151959.jab2c36oejmdhf3k@skbuf>
 <Z6Yn2jTVmbEmhPf9@shell.armlinux.org.uk>
 <20250207213823.2uofelxulqxpdtka@skbuf>
 <Z6aIGzHWdzF5Rlci@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6aIGzHWdzF5Rlci@shell.armlinux.org.uk>

On Fri, Feb 07, 2025 at 10:24:27PM +0000, Russell King (Oracle) wrote:
> You may have noticed that I'm no longer putting as much effort into
> cover messages - and this is precisely why. I honestly don't see
> that there's any point in spending much time on cover messages anymore.

I have things to do and places to be, and I'm sure you do too, so
I won't drag this out more than I need to. I'll just give you one
self-contained example of what bothers me, from this very thread.
I'm not even expecting you to change all of a sudden, I know it's hard
and takes time and a deeper understanding of what is happening.

First of all, if "I tend not to read cover messages" isn't sarcastic
when you've make it pretty obvious so many times that this is important
to you, then I don't know what sarcasm is. So, your message starts off
from the very beginning by not acknowledging the way in which your
reaction is perceived.

Then, your message goes off to justify your reaction by essentially
reiterating what you've publicly said elsewhere about not being noticed,
making things sew with no Singer sewing machines required, and what not.
Apart from the fact that you seem to build certain expectations of others'
reactions in your mind and behave bizarrely when they react differently
to how you expect (or not at all), my personal problem is that you've
responded to a complaint which was really hard for me to verbalize by
talking about you, again. Everything I've said in the previous email,
about you expecting more respect and attention than you are willing to
give, still stands.

You are an important and valued member of the community, but you don't
have to be so hard on people when they don't rise to your expectations.
Your inflexibility makes it difficult at least for me to find a place
around you.

