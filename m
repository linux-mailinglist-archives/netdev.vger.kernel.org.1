Return-Path: <netdev+bounces-137022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB26A9A408F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F838280C20
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D5F18E025;
	Fri, 18 Oct 2024 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChDbFg/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38CA42A97
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259856; cv=none; b=PynSI3HBeuTiCrcT1+fzF6uYHWUQ4f8UwdvRhdDIfbyNiw7kPhLk+ceaANs+h1eWDVVJNEJNREHLA2wf2pPCB+OrDo6Ma5Qei8cF9BrlSP8XAz5klhYF/as8PDZ+liVF2iI/PPZLQQmn/HQmd4MqXPYh72k15m1fR7sYbErnKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259856; c=relaxed/simple;
	bh=ipVkCSb2KEjAp0Xk5vtq9y226WzcE+K0GEN4bl+/mSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLBWhnzlVjxmHHBJa38I8S32V45EZ8JQMn5uE6bYLrPejyAemegZUPP9ZZDbpjjzFD+Lxm3Cjecx1AIEBUF7KN8NDtPFRcW1U5tYgPGrDoTacpfGr5HdCK3TRzKUBTPXW0TpLK9EH2WqeQq1J0pUWbiXSGtHE08yr4NEWDm2ulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChDbFg/u; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c94dd7e1c0so2718717a12.0
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729259853; x=1729864653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipVkCSb2KEjAp0Xk5vtq9y226WzcE+K0GEN4bl+/mSw=;
        b=ChDbFg/uIuU5yPTrEJXorOH7BZLqbv0OcxDu7mqKNv5tL8GgbV+VcmA8FFY01pA/Ur
         fR39qDHC6V7rrsDakgu1fcQmtkgTISaDaOG7dxGdBmn05VE8Nx6SxCtX12X1eQjGhIoX
         E2/AtgCLlW5U7QVE/jqxbOcsfsG0fYzavAHsrXwH9rmwmzFCHQGjo+5evCobWQgiYcXX
         D7lUFN2erpCqSNGYKtYsw9Ak9i8ulxNBeusdQl8PljVwST+2m89D97BtogaVEXNjqlrW
         GXZgTFe27XbpH6I4g4Opnns7pxnNWFpU9CDr+38YQyvcEi+wqWCfaKy5INHotJsBvSvX
         0k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259853; x=1729864653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipVkCSb2KEjAp0Xk5vtq9y226WzcE+K0GEN4bl+/mSw=;
        b=nCCy3Bo53YG4YXQu0O0zhRVT9hB3hLKreOz4ZtGAIY7JuHZaHPSL+2REQ5iDMNIH11
         thrJJ2nFbEFq/C4xOGGDnTjZc/brKUuKlaEMSJ4/KTCdU/XQT99VzNgwwXU+ZsJXqXAp
         Ma/52bNO40J2TqwXNeozrEnjXrVJjvxhVPMWHyDvFwr3nbMhZbPetowuTTGX2R55FlTZ
         9dXXzmIjnY27cemGHuKOwAhbsHkNOO7FnJ3smXg+Kynkwu+vNtSAmPd3sozH00WX+zpk
         rTvU2vzSyqgkaAp5XqWsAsiaXWO6XyuVggAm9mPl9xU07fe/gp7JoQ84LXlgXq2qn+Po
         dOSg==
X-Forwarded-Encrypted: i=1; AJvYcCWW+AVoCSS8s5mUMRC5s1Z9EOIdaKbg4foipjXi0fV+ov+ylJI3a2nfhbRpZbac5VvF3v0z5Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySNkjd83QkFH51WtlUFBQsJCXFnvcu6/F0BblAFcjBSwv4FNh6
	IBDdsofk0VINolGrE/0O/ZoRjjUYpe++u8JxApb9af08sKHej8s4uWcjzj2CpEiSyTzR+BcA6Fj
	aZ8NjHRU4LCvWyi33a/D+GyZqy3vZPMNox9slhWe3whJZKjwO30e8
X-Google-Smtp-Source: AGHT+IEbqvbRyzpq87xGk5ZQBUUYhqR3Y9fZSKRaEKzo52T4mtFd5s7SVqUTB0fOv3TM2uqt+CideEcVaEbo3Evnym4=
X-Received: by 2002:a05:6402:d07:b0:5c9:85e8:e866 with SMTP id
 4fb4d7f45d1cf-5ca0ae85af4mr1891934a12.22.1729259852615; Fri, 18 Oct 2024
 06:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018012225.90409-1-kuniyu@amazon.com> <20241018012225.90409-12-kuniyu@amazon.com>
In-Reply-To: <20241018012225.90409-12-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 15:57:21 +0200
Message-ID: <CANn89iJDz4j3NaUEKDA87oRC6WSiv9W=uLWV6w-P4L0AbJTF1w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 11/11] ipv4: Convert devinet_ioctl to
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:26=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> ioctl(SIOCGIFCONF) calls dev_ifconf() that operates on the current netns.
>
> Let's use per-netns RTNL helpers in dev_ifconf() and inet_gifconf().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

