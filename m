Return-Path: <netdev+bounces-171055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08643A4B4C2
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 21:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117B01890FD9
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 20:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E31EC012;
	Sun,  2 Mar 2025 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HQpOLb1E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932C71EB1B9
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949000; cv=none; b=K84rJkl8nmsFy0hg9WLuBdKFtSUHayf6aoChTX9ENhM6rO4jItM6yuzsjR8u5mfibAuks6HEddSinUMp4wpspfnjqhh2A2fjbeRnAdU4iHRpm/yh6yGqkIelKZrLLyrxl8w1dsB6G+gQL+QwW7OOkkhzx6yAdTJAs/29/DOr3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949000; c=relaxed/simple;
	bh=cbj3uI8EB5WZ0psDlymBMSV9slMKezbCAVkBVOw/JoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5EaRrx98YpA85V6IS5RVINQRGo661rJx7tLWDDdP3/sYW2DZeZ3Q/WKm/Dmg/Z0S9DiojIda9Y66Qublx0tq8vyCvowxRN2fu/7jISWzkHzZst+a4x+UEvLg12kkWRdGTlxXT5vXm+kVO0+zDjflICj8nd80eeVXl/ebpA9+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=HQpOLb1E; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so5927746a91.2
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 12:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1740948998; x=1741553798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbj3uI8EB5WZ0psDlymBMSV9slMKezbCAVkBVOw/JoA=;
        b=HQpOLb1E7J0DJ/TUHrbGVD/fAsHDASZL4ilrvL88nnFh9KrE3/mC4B/29ibltBtmws
         Ge+0nvhzuZV9dLVIlhAZq03XZucUcuftC7ZK3Qfzpz2+D+aZPJvHLtBAgpaeeXuJb8DL
         aWab1u4sp9QCn4i1CYc/e+WJNWFd+HsS/bHwbvR4vMbMohe2bYOOGjTEf8aYUe/CHQ7q
         QUwpRsEWOosmoSb2IPV11QgyEwk5k7twNfZLnaYzKfQ79eLPGmGEVwEzMMQpf68RjoTB
         ZBBX59bR4iajjdZVQ+FL7OcK7Gkbosxvc6l9K2YKw2CqrhRpfBJmthDHqaOuEuAx5is0
         NWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740948998; x=1741553798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbj3uI8EB5WZ0psDlymBMSV9slMKezbCAVkBVOw/JoA=;
        b=N/trgKZ/Bays9Mf1G/ymF/JAS4SC6PN0gH+Q/09WKUOfjo8mU6KrCq4z49Xy/BfnRV
         hvHxxVAn5jXFLibDCWYTIehYF2iBOY85DccUAvxoIpUoG7tIM1t14AKNqcn6PaqeXgoU
         hr6X4Osb8KzswC1lc13llf9l5f1Kybq9jXbgX5VcOulhOhv/2vgUGhAYUjgDlu1Z4b8M
         1Nh3zqtLFbyA2UcAUpufjKnBXMDsjsn8lnYNBMj5cLBjyN3gvKsAHhQLcE2TK+eiHMOv
         B2DWURe+NGlsQt2pKYnVhM20ynmege3+0rTKzpPkyCOiBVv1J8oAQZpovuPUeiQWFihp
         HdtQ==
X-Gm-Message-State: AOJu0Yxx8yCNwhWR92Va+21nDeZgBZap84wUyxLsFzUZ31JZKa53aoXd
	d92gedFhmh3/jw/wAZ4phLGmC4NOsdoiVx+yk5KQQ+EjsskZu0/0Jv8l0ZMmkDDz0snPc6752YE
	g3YeioYDBFnKGRBkISZYBIDOTEGUkWNX2M1u0
X-Gm-Gg: ASbGncu+xGNmtitlOVz0RD+sxWnGUJQp9TXK3G7/bZ5hc3Vv2DIzVdJbeSyofFz0uhU
	AwCnTNS+LXeEwNNdNcu6hlI2++J+fIEnNBpMItnC8MggMNOzlIRDON2i0/00ZI3AESZSHENAkGs
	tFbRnOVE6snvxkaMp0sjmoURHOvA==
X-Google-Smtp-Source: AGHT+IG7LfyrcFJPe0lSvvVierJrtzeo33UzKgZ2jsgwYU7MlGlkC6jZsWk0sU0ni+SrRYI2jWU2KRSH+rjmMi/5qjA=
X-Received: by 2002:a17:90b:4990:b0:2f9:cf97:56ac with SMTP id
 98e67ed59e1d1-2febaa8b67fmr20367664a91.0.1740948997904; Sun, 02 Mar 2025
 12:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302000901.2729164-1-sdf@fomichev.me> <20250302000901.2729164-5-sdf@fomichev.me>
In-Reply-To: <20250302000901.2729164-5-sdf@fomichev.me>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 2 Mar 2025 15:56:27 -0500
X-Gm-Features: AQ5f1JrEAjJXTHV0fAS7NtDPC_b2kS0-Ht_9reBYIuCzPIWffH_3OBcLQhpGg8s
Message-ID: <CAM0EoMkj=s+0G7AkCBdgBp5vM3xhusUpuX3D+oQZL+hWPFSJjA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 04/14] net: hold netdev instance lock during
 qdisc ndo_setup_tc
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Saeed Mahameed <saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 7:09=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me>=
 wrote:
>
> Qdisc operations that can lead to ndo_setup_tc might need
> to have an instance lock.

Sorry, havent followed this work - "might need" here means that
sometimes it may and sometimes it may not need the device instance
lock (I suppose depending on the driver)?

Since i dont know enough about the motivation for the instance lock, I
just reviewed for consistency and for that:
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

