Return-Path: <netdev+bounces-89512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 622EE8AA821
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 07:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9448B1C20C40
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D6DBE66;
	Fri, 19 Apr 2024 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JDFCPjt3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D463AEC2
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506306; cv=none; b=WUzZaiKzdm6hqgrJatmFgOnJaZ+23CdGT7ukQWex3VnlRStRyusTMIV9awRSEc62ioN37WEE4i1ZEEy74CkqRN1PR5JYtqTO5Qil1Iib2JybfPxtkqdo05PdwK1SXJcz2hNkO1ziTkf+WzpMrcIjWzcqR4s8msMbngs8bOMF2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506306; c=relaxed/simple;
	bh=V9PAMjr0rPC/hOsi1So21FyFLap3XsLhjMbLigfrkm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eywnThbY+ifAyu3b4qJKHmMTgOxbUu4hEhaEeeGVKQAvW+H5OBIVUFV1NqZLOzgRs3OW51WfqngI7L4PPTIcguPD9QcGCysLEmLP8jIB78KgABKHKa+IapnSxIZlzm9zn+stpYmvlNjSAJJT1Ia8WjLd80OmkW4JNDINIGjUZ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JDFCPjt3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so6610a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 22:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713506303; x=1714111103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9PAMjr0rPC/hOsi1So21FyFLap3XsLhjMbLigfrkm8=;
        b=JDFCPjt3l7yuI38fvX/NIKllkahQiuIFsuJt/HbeUDPdQFN6vhffjv+BtIN9M0Nhtf
         yI2CD5A3GxweiJigieMimTOuPmJu8v3tyzs3KH32APeOrUinkyxSGVwVQ3I3wRRQyOMN
         SnzLIpoviL11YBjcBAK9C7E8ie2J/ObN2JyCj47+YXXb67CwzpB3YESwdpyh673hHVy4
         vnRllHUGmc5P4tmE++VcTSObUJwHIjSm0+8NcxpbpMoIileo1yOpH/y+WmMxmnKQ1Obm
         l9OZh/eB9QI+6oL90xw8C8qdlyfL8LBJAMHipQjSJ4f+RqqmeRNri3vMjycwjoGRwpKz
         3snQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713506303; x=1714111103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9PAMjr0rPC/hOsi1So21FyFLap3XsLhjMbLigfrkm8=;
        b=KckVrIHdPM92qE4bPDlFA16HBF7FvBzX5QnYrm31HiejLLzegEb7jD9+fyy6kaO5dw
         juAE/bWTKgmO9F7CVJEzahy3AQ2/0S+kO9zrmiVoHsK8Wkwz+L4pnYyTk+zu/AztGA/v
         FoQ3t2BJFFUWEhcaynFtgpJr6vAViLdHVRg9kqxPS6D7lHdpvKapzoCENdSfh2ZebIo9
         FwBnIhmZKFa+osaSwZBVdKXWnzVCaxa+EqwuCriAqbNGP2reiY8FFHD5j9qugGweHQou
         1iIT97AznmWbJ8YeEPEkUhQyl8u7jKEvZl+UZkELViHIpNfqR7xjKRu7VWcnVVPkA9V2
         zgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU42OlS2XA48YswLp59HU4U+zEpkf5pkdMRLXzxNdUapBufrxdag+PheQ/2umJyILa46ZtXOdEeXAQ7saB7Zr67J6nAYK65
X-Gm-Message-State: AOJu0YzNDenghoBb2NjeBOLsG28iWvWlLyWZJ7ooJUos0aCv8hmGHF0i
	PN0QQwmNXv8m3c+aNK5tJRj8qVCPtLhHcCTSciNaYCJXQXJ35F21EHOjfHxVgVelk4hNEjgDbDk
	ZdkjkXIhjrqmo0qY+MQRePn2yA+LvSdqYiJsR
X-Google-Smtp-Source: AGHT+IHs4Yn/92p8dQkfSaKupfPj+FMjeg5Qw1nr88FXKh7o865bJGS4gXQGC9sZmMBda+iQY8XaK1BiWv/PMJoKQp8=
X-Received: by 2002:a05:6402:5216:b0:570:5cb3:b98 with SMTP id
 s22-20020a056402521600b005705cb30b98mr138483edd.4.1713506303004; Thu, 18 Apr
 2024 22:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418073603.99336-1-kerneljasonxing@gmail.com> <20240418073603.99336-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240418073603.99336-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 07:58:12 +0200
Message-ID: <CANn89i+3dAmw3piswCAen3LWnABy4SR1TO2CtU+qOwEjpoByTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: rps: protect filter locklessly
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:36=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> As we can see, rflow->filter can be written/read concurrently, so
> lockless access is needed.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

