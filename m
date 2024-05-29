Return-Path: <netdev+bounces-99194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C468D3FE3
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 22:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A59B25A99
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291181C8FC9;
	Wed, 29 May 2024 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="23fgMePK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803321C8FC3
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015953; cv=none; b=T61MxFoRBJlhX4xeo1Dt2GfBzqHwWGKwu/ZjzvFNaE9vpIbZqIWc1aCf06NcHD5iDum7FyNbv7/4PVJ/9W97XsQpYadOPLyfxFiYE9hUtRhpLSUAsHlYm8jhN7yW21f5e3Y7GvXQRcShb9VrFumO5qaS2IsXL/rUm953LXcx6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015953; c=relaxed/simple;
	bh=rzcqoLBlndbED+EVMQJtLRCaUVohtIiZxEKkdQs5pdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqiHxBtVP24RH/dhq1RrF55ipk5NRDWbti06QYH7KvfMkri42qfYpAbKhbUtYsUlTWjgj75Enp/msZc262iSiVV4rd9cr+YjjydNMY3Hn/nySkZq8P0hbPH6tK1Vl20tPlWOY8izKgdTBZyxYy28a/maMhW69f7g6Dvh5sotTe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=23fgMePK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57863da0ac8so673a12.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717015950; x=1717620750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DcHeTwlboRBzaj6x5OLjiTQ7XlOIaLLgevvW1jm+YQ=;
        b=23fgMePKCjtSywyxQ+NdEc0BI1f5eLui+t5fYlzI66DZ3Oqp1upAaGv5ItVnIZrwJi
         j7PlICXBSAQno+uS5LzO/7zLdDCxpPTcvxZ2aP2CzBPBQKTjWSI7ZTqBB+ykxMNxISdg
         zwNx6LCFRjZ5xLLoKGkwcT5atLE5pH261WHmoJ2/ZohXDtg0KtIOr7CCChhYBH9boT/e
         l+KOapjNe9D2ywT73nrz27vxeVQqEKmoq+K3tq04ADMC6BszaP/x/LKNEqcCDdL/3O/b
         uJKup61yJATaQ/XBOsFJHdEHq6xjcC+5J869Y43/iytl9blAJlA6Gdn8qQFNDh0xDIMz
         8wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717015950; x=1717620750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DcHeTwlboRBzaj6x5OLjiTQ7XlOIaLLgevvW1jm+YQ=;
        b=Xw5AlnLVN4tUb0WhvQ8bNHpZsisWOTGR8vEpV817Dp6QHonZspupC0EROumIoAwYuW
         xx086gfMlJlvLB2i9WB2SlQku3Sur6rOhqddyCmsdlxHQoQNrqbIwrPm7WkFXH1sWH44
         XNFzeAQ17KSNY0UJqXZynzN5ZMAsW2UmHdAMdQi7ZAQDPhTGDs3FRdZ+JY4p/+Uqem+U
         nQnNUYRCWeiAF6+4vUZaJfupgZT5Zp5wcxSCb3U6q+OhQ3XJAopkSRYWLtc+Coav4XQH
         zhuTa1eOYv2OKOz4ctwKufFzhDUm59KH2eFFeJ8BdqEd9P4KJ6A7mQwdNNIznTQL5GbH
         xC4g==
X-Forwarded-Encrypted: i=1; AJvYcCVDl3L9hfey+chHzB1+LLKdCQDJ+Qh0w1fgd2TWLBQO7lGzVeXkyTGlCu0DwpBvikVa/nUpmVK4eOomfY/fpa3LkH8dFH0/
X-Gm-Message-State: AOJu0Yyk1aKjQfPJLI05ThXA8q0qTgf+s85+VGMO0vBbBCIS4dUtoDx8
	bYl03Zd5ibLWPnIBqUzcPVs0NRKGKBcRvh+b4XHNM06PW74cg8wqaCDyN2GD645bWJEKHrL9Skc
	pvRwRG1DShsK9fUutUR3H6Dy2H8pRuH6+4G0myXnhsE/ddNM0TPHx
X-Google-Smtp-Source: AGHT+IGr0ou43WxyDSNYEeELUUWUCHHYwEsJlMz4raecWsg4vjarHcMY2VITpUHVkjEgIQpi/jMpG7QV6jJtf+2GejM=
X-Received: by 2002:a05:6402:c09:b0:574:e7e1:35bf with SMTP id
 4fb4d7f45d1cf-57a18ca60damr2500a12.7.1717015535896; Wed, 29 May 2024 13:45:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418073603.99336-2-kerneljasonxing@gmail.com> <20240529203421.2432481-1-jsperbeck@google.com>
In-Reply-To: <20240529203421.2432481-1-jsperbeck@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 May 2024 22:45:21 +0200
Message-ID: <CANn89i+rAbZwRR6Lor1f7PFFzQiajFx6a00sehmu4B96KqVhSw@mail.gmail.com>
Subject: Re: compile error in set_rps_cpu() without CONFIG_RFS_ACCEL?
To: John Sperbeck <jsperbeck@google.com>
Cc: kerneljasonxing@gmail.com, davem@davemloft.net, horms@kernel.org, 
	kernelxing@tencent.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:34=E2=80=AFPM John Sperbeck <jsperbeck@google.co=
m> wrote:
>
> If CONFIG_RFS_ACCEL is off, then I think there will be a compile error wi=
th this change, since 'head' is used, but no longer defined.

I assume you are speaking of this commit ?

commit 84b6823cd96b38c40b3b30beabbfa48d92990e1a
Author: Jason Xing <kernelxing@tencent.com>
Date:   Thu Apr 18 15:36:01 2024 +0800

    net: rps: protect last_qtail with rps_input_queue_tail_save() helper

