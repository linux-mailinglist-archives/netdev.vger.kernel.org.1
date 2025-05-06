Return-Path: <netdev+bounces-188340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 113FEAAC4F9
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDBF523B80
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B2280017;
	Tue,  6 May 2025 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyPobsuq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C51127FD71
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536296; cv=none; b=IkP+HFG+vxRrY9L2Mg6RHc0AV/7FdpOt6qHQYKbE4l9UEEhrsjedyBffgCKqrYyKpqcyLgPrlQwaw7LCgbK+ncWzBFUcu30HPqGjgtq82zOteUotnhoe1Q2IMaqp+1m0vLbl00cVuKr6cz9DYo+ddRnNSnxWWeLj5A+NFwVBl+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536296; c=relaxed/simple;
	bh=Y65CVUPy4HCs5i0pvUGOFRml03eE5qEKO0qjMFei6bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dk21yiw70bQI+4L8VG1k51sCau5kAAcQTQV+IkYpFZ4A/pfbwn9DY4XHGNY/Rx64+Xx2CrVwrB9TOX250SAhaT0ZaLYd+bwjV4Sy/bEG9hXkjamZznt2Ts1RRa6EKg7qgq1exSO53vA6KxA2cHdg4NMj/lXqP6tgfsWW4E+cCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyPobsuq; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-606477d77easo3336522eaf.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746536293; x=1747141093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y65CVUPy4HCs5i0pvUGOFRml03eE5qEKO0qjMFei6bQ=;
        b=iyPobsuqEcELm00VufW3WXZlzbue3/6A1yrm324cH/AI4yIQsz/xENOTqM4Gz6jyjz
         A4MjZiM0WCYqtojM170RLAUEUisEb4urV5CmQV6PjMQT5BzyrtazPttwe3W25EJzWgjG
         PEbPVJVSkvFVQc0oLOVcgQlk38bScuZb8kLGOGNeKoFwejCZaZlAw6qZnMQFsu1FbqxO
         7n9/mQ3MIOmWMV01+hunETt8J31OHCkOB8AjRDtU3WcEwJl4zC7i8kGBjb7xhXw9NLhB
         RTECwRM1G36snuSfvhEy+5n1zICnkbw1bvJQUE3cJZlFGDwX0Xm7eSpEv5sn2Rqb594M
         0pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746536293; x=1747141093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y65CVUPy4HCs5i0pvUGOFRml03eE5qEKO0qjMFei6bQ=;
        b=jUH+EnhD9JDT4F3HwYekpCqnHLGoXklpPYQXRJHJ23QNS7SSEkLN1mrtD6xc+TePNU
         dc5uJT0m705EbV/hgAlhRYM4niMH8PrQH7Kq1qlkoXzxChZlFb4VsHsP0jHSqi8O/P5B
         Fs3EtO6x/Ux7DBRFnEnGoF5CRbKOauqjr7TkznsbQGqTEDOUyGw54PRbTsZhVX1vyTCu
         oDwlFw99aefKfvl1TeX6TnOFB9L+Ox8V+X1hak98KSfj+YWialHtUN+tF19c/MXBNGLX
         jYB+l8Aq+9GDN5YaBYGdlBvA35QJrG9SFxTuG9IQxvJV+LVYXQvZ5jHZ/iNTmvZZdrJ9
         kZng==
X-Forwarded-Encrypted: i=1; AJvYcCW8Zwg0cTIG1sFA6zfg5YnJXhRrgcMUNv9WcdVfdsdAY03zEDDgBA+kK25HR2goZrhyGFrSSwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuickaCJUmVrzELstRO0QgOKv13Giz1GJnmXB5RgvWqazCpGCE
	TUosVte/20F2ch9htalYEU6ptVRtniGliiUwUAsSQVpv7v0ROTUZPxxfOsJf78UBFI058lWDccW
	bCo4gkMI+GStiaIm5B2DwHPINkyQ=
X-Gm-Gg: ASbGncvCRx73Zro1o47gwCm/jVBACSOHzlTGxbmmDvUvuNd3Vtuo3/r+WxjQzDGt9mH
	Qh4Z7iSAA0tMhA9rYjc2Drf4b/Ocb7T8ezl9gGYeZh5uXLidbaehjLZMmSyn5r8rvwHilmPwYy8
	laZHf9k150TJyHPPvH8PVtnWBh5WgLWTWXs5i/I6/a9vTsaVFZsfE=
X-Google-Smtp-Source: AGHT+IF9qzhM47vjVsgsB4lio2WEhn6WMLWraELp5q3ja2ZwOtuEAZxpPvrZgiooTnqOGTR2HVW6lV52ImpjIP0JPkY=
X-Received: by 2002:a4a:df02:0:b0:607:de19:a537 with SMTP id
 006d021491bc7-6081d760d4cmr1928646eaf.0.1746536293375; Tue, 06 May 2025
 05:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505170215.253672-1-kuba@kernel.org> <20250505170215.253672-3-kuba@kernel.org>
In-Reply-To: <20250505170215.253672-3-kuba@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 6 May 2025 13:58:02 +0100
X-Gm-Features: ATxdqUF8aqhbgMsBigezLa52f4opHQwLWRdiCpOupkGQuXOjai4DhdJ1e7FWErc
Message-ID: <CAD4GDZwk3UYfxD-PnkorWOz6PfYw_TqgLZgT_Sf7PeWWJQ_K4w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] netlink: specs: ovs: correct struct names
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	johannes@sipsolutions.net, razor@blackwall.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 18:02, Jakub Kicinski <kuba@kernel.org> wrote:
>
> C codegen will soon support using struct types for binary attrs.
> Correct the struct names in OvS specs.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

