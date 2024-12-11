Return-Path: <netdev+bounces-151159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A8B9ED209
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367EB280E89
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C931DD871;
	Wed, 11 Dec 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scZu4i3D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A4138DE9
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934852; cv=none; b=SAh7vaVTjstilM1OtNzwoMeZeZ1xhcay/yomtIa09pNehHGFL9vIJS1yPuZHFwCPNbgFETrWNbZ3vJmV8vy6tsR6hu+WMZDz6KyUzAJnGf+WRFUoGMT13WV+XW82GcpJZyt2pch5vsMippFKI2BswE9LybtYnJ4oKs3/wtc/d7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934852; c=relaxed/simple;
	bh=Wc3BI5a4DQVItmA1LcSv4S4TnOBWHfkmOeIWFty/edg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vn3LAbzm0JFOrgt/nvEpfsIWG4a8PmnAMc8glb6C23ehnsczk6fWi0yyzZQFzsD18dTYT/+Dd8Sn1m9rf3Iwkn3yrbPj2cBlerjGnw0DsWoLc5WkUjmNALb3YfSbN+QHPbmkUJ+4kij1OaTadLlFq0ep8bmuPKn1sIpl3oV1aHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=scZu4i3D; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401fb9fa03so832389e87.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 08:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733934849; x=1734539649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc3BI5a4DQVItmA1LcSv4S4TnOBWHfkmOeIWFty/edg=;
        b=scZu4i3DPVPB3wBY/tJutMgP7deLbGvZ0rswMkCCFXmscvldO4/9v50Pc2M9um3CII
         XbhRRPY7Kaoje4WHSbNuNNGVOb+PGE41V+3HWIOcqYwPgamNmbUNLyQmBVfN10SF464Q
         yzj358EWqU4LHwBpoqmnoEItKZL4i807y5SWEB7eV7EY97rJQ54xidFU8q5xd200bI5I
         O24LWm1MCnpeOmLWS4lzxHVVXJpbr17E/BJ5p/EzgE8uTJOfvo45uT0gKO/CIRiF+OlR
         T7wOaWgjlhOA1J9VDaYapNzdRvmQYh+An1BTIYNyqx85iLomRLcDpwxH/H7geaWLFVCa
         noVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733934849; x=1734539649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc3BI5a4DQVItmA1LcSv4S4TnOBWHfkmOeIWFty/edg=;
        b=MO0Q/ttYiydhx7JguK770iE8y79KUAFf9h7uhSiPk5fCLYkKG2TgaWq8K3RrO19hM/
         fnmxYNI4J94dZlvSH4JGlMEUMmIbIN+c2d8QKy6ldySkwWcTaKQf3v4fWdZeTr5qu9xD
         jqWBjplsAoe3vN/cpOH1eoiwHASAmEJhnmvMOAwofflwz4T3r0XwnrYezI1rlkl4y3lw
         acazEylv5vti3FtmJ/gU9eTLJOvPZm2rv2ykgaMqcuePFMMfUL7fIrgEvKujVxy1aXHD
         /y+GI0rqQNIWZb7N5/x8u5lxfpLOYxrp0wuLx9niG71nBfCfAa8sTw4qT/43yoZFpRdk
         uTNA==
X-Forwarded-Encrypted: i=1; AJvYcCUR2kDq3s5TlTAQKBYoX4lUiHjpwnFTlehD3I2FLKNN1CV8OQ8wis2m4fKfrID+0Sn4nEWMVLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05bXpm5r1ROzN8/nPgSROft9K7PAXzrphnBg34nxO/94vdBOu
	BMZFw/iVmhOL8+tM6M5t/8964+7iNb5p0Ulmf6iqM8vL0pEzxw1PP3B2+YL4f/WtBXoeHQqiHGq
	xTFi2UnSMuGy6VsTobYTB+I74mk4RrQNjyct1
X-Gm-Gg: ASbGncuV50IJCPYKCGOUSm9rIztvo4m52fRQWjBYFj1xAoPRpEgZwkKSxPoQ07c5gzq
	5IaItL/EvBEGNTKTDpA6hM/ebm8MOG/pRJi0=
X-Google-Smtp-Source: AGHT+IGANx5FXJZ0PiAIVACiotPBnFNKQGAlWqPPmfYeR5t6CiEoR/ZaFnWrjiNlwU+8vBwKPyf1creuhLdpisW0A28=
X-Received: by 2002:a05:6512:68b:b0:540:1bd0:347a with SMTP id
 2adb3069b0e04-5402a783b95mr1192159e87.26.1733934848532; Wed, 11 Dec 2024
 08:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211001927.253161-1-linux@treblig.org>
In-Reply-To: <20241211001927.253161-1-linux@treblig.org>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Wed, 11 Dec 2024 08:33:56 -0800
Message-ID: <CA+f9V1OssWoK7gOSx8Vv4c=bVnFkWH-0kDLUay=DoWGEx8gEEA@mail.gmail.com>
Subject: Re: [PATCH net-next] gve: Remove unused gve_adminq_set_mtu
To: linux@treblig.org
Cc: jeroendb@google.com, shailend@google.com, netdev@vger.kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:19=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The last use of gve_adminq_set_mtu() was removed by
> commit 37149e9374bf ("gve: Implement packet continuation for RX.")
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>

