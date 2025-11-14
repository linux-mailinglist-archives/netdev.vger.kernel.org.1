Return-Path: <netdev+bounces-238686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCCBC5D943
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D94264ECE3B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20777325485;
	Fri, 14 Nov 2025 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEkav2q6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4132470A
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130154; cv=none; b=qanu9j0SMKyOyHoAkr3pUyuRCR2EiveXCHriBHjVFxVyIsr9qq9HhPrrl+if9FfY6GEdlcnBRd5Py69V5k0QkPSYT1LPf7L7/Jc3wyTLP0QqmXFzSEpLuaN0RFspHlkQ6SDwS2XawhYGfnTOmnjs1JB+mpjkSmNEIPBjontcrYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130154; c=relaxed/simple;
	bh=xMi7tdbDldaq8tmCgjFjHSKBStfhME+c3/30YcUqNG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLJ+biZ61fgdo6I9pBhBPKBgad8sqF3EHRjRz1jICqGlXHnihB4Eq82JKJcl8IoBiEE9vYO7l8huqCW3pao1CxMznxxoGRSuNnzWzmiKJSPwFGxsPGtF4Myng+QhUkiJTeZJloymkTwHbcpTatWXI8h6KW+b2z4CgeiNaS/NVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEkav2q6; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4edb8d6e98aso424491cf.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 06:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763130151; x=1763734951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMi7tdbDldaq8tmCgjFjHSKBStfhME+c3/30YcUqNG0=;
        b=KEkav2q6w6Q+zEHmF3Ozj5QWswzclWWRDTYfO0wf1qH+4d4/mBnON4Fj/2ynlCHSz9
         399g8VMzlHBevV+KKKV7bY+aWfd9uC1wJSt6raWJXr0TVu4HRs353nAsqN+aLdtEs2Oa
         IpHbKbnI1d2+hZvMnOmlVp0HgggjeSI0aEmXt7t+XRTR/E170L5s9I4ZowvGXkCRul+V
         zDTz7vj6kOv95q+lcxPGA+5GZ5UGfwbXaahXapmXW6qMAGnTHp9sOsZ5FRTy8f0NGQyj
         Vg02VOWgm9SM1DrUr05pdCMJxk3Fn0BriskkaX3kHElzDhderGv7Glk2oTlCuY9Cjawp
         ZKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763130151; x=1763734951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xMi7tdbDldaq8tmCgjFjHSKBStfhME+c3/30YcUqNG0=;
        b=FRBG0YlewsyIJR+li6NSmwGp4Bf1tVHZJahO3mSYfXdpDJMP3Vn/JWJ0bEi1o97hm5
         gEdwvOUBmDZJO2RveOuKesi7WMZtx4eSLlTdV0T36jWJlWtTJw5NtIrjCWMyN8OKtKPw
         NOFwKk2hkckc5v1xx2SC+8+Usw6hqBaEinbEMNVY7jIKwUcPmawLtaxkv3zFHLyi3+7v
         J4Et45+Krj5jGB+nRuaD/zM0rRz0WWm1IPUKtGw1LHQcrqiB0/tcBFdFoCCF8i4J1L39
         9bWSJ1f4mQBIrcKhEax1Yq46F9S1EIp/lERupIFxdXua7+JTzZsqGUwmJUkN466Wjaxn
         h0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCU64Ln7uOecFFiWX7IjX+KaHY16w1DSGiZG1IxA4k0m4S98LAKJfE/RSIvBLW0RwoQI8jXdvzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMxyEK5504A65B/mtfz/ErKEzUd9saCodRxHRQ9dTgpZvBP1iV
	RHED74EDeNCi+3nNzjNGyHi1nxR9AmKVSVpXHUrze4hUFqFlz/LeWeeX1CC031VEXdWQ65W6Tmd
	DW6QNbb/64GE+R4dHRxtAUIKjYB4wsRS9vray4Uu8
X-Gm-Gg: ASbGncu0TeOmGrOskG+UIOf6BpFXctjdsZFKs6m4FVlAZTBN/Z3hLKkyogm0jtqTs5E
	EIIPIjV/6seIHIVHBdYuK9U4xsiRokPM48Cq2idr8JxWOl5yoKTk2Z+83qfMON28rY2UPOnX/Zn
	/tNc0hhzSIGKsCjoUe0tAR4pttMVnQPHoiEjfv3CfkFthWM++CLWLV8f5gYMytXDpVtG46aqBAL
	8lI1uFF+jJKURZlKT4ZLGus2ymQnzUtgUbs9QJk0iKaIcmwTlTgF7nSy26NrMWLfUM3y9bBIJnI
	5l2zmOnmEt/SnjsrPRjA0Lwo6+jwE9qxLaxwKun70jQnMPCySknxc7J0bB1By6/x7bJKyg==
X-Google-Smtp-Source: AGHT+IGSHOlWwONdBnBLRt8lmhOkguNkP/2DkFuurLWk0ejJpkatNcYjoDZhEHKldYGOKQCva29nUx0FHT+xwuf6WgY=
X-Received: by 2002:ac8:7fd3:0:b0:4ed:70d6:6618 with SMTP id
 d75a77b69052e-4edf3231a3emr6591291cf.10.1763130151056; Fri, 14 Nov 2025
 06:22:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114135141.3810964-1-edumazet@google.com>
In-Reply-To: <20251114135141.3810964-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 14 Nov 2025 09:22:13 -0500
X-Gm-Features: AWmQ_bm8n9B3aR_gX134eF_yU81uB3HRDlPNoE_cC-VMRQHPPk-5LnNb8l4r3rc
Message-ID: <CADVnQykywEZ90j3UfM0p3=FbbApAKKA95dHO_vP1x+Nb2XphPg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reduce tcp_comp_sack_slack_ns default value to
 10 usec
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 8:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> net.ipv4.tcp_comp_sack_slack_ns current default value is too high.
>
> When a flow has many drops (1 % or more), and small RTT, adding 100 usec
> before sending SACK stalls the sender relying on getting SACK
> fast enough to keep the pipe busy.
>
> Decrease the default to 10 usec.
>
> This is orthogonal to Congestion Control heuristics to determine
> if drops are caused by congestion or not.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

