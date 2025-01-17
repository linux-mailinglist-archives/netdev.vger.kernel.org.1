Return-Path: <netdev+bounces-159481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E299A15985
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33E5188C1AA
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF221CEAD3;
	Fri, 17 Jan 2025 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jU4yOI/2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F23B67F
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737152870; cv=none; b=q7IwraXWkioOAj93r07L/Vwt3d1XXIf6VsKenyKbFeehA7yqYiqZCm3r8melTC0B+cEgCnpyxJtvbQ7gOtswoXQF5qpIChXMUATwKfYHrrGBp23O/Aizc40k0i/Y+3Rko6S04OiZC1I2jOmhWgdVx2O7dVeQG8wdE/0vXMKqiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737152870; c=relaxed/simple;
	bh=wa0DMPdlPlQ3EzT4REGbFRr8PW+qEY8zytKqoiMoGLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDwu1yxMpBbRq5yWx6FlhUTyR1OfmAKIobxKTxLP5Hj0nKckYjWHGSfSoZKu+4NG9SDB0oqNkQXhOH8HIOdpeRsQXDX0yYZOJa87y8sE7OSJbFEqP6SND3A+Y6FyOmYavrO2LQPtzBggDyFXk2AULwaBllOFp9Bhphb13561QyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jU4yOI/2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737152867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wa0DMPdlPlQ3EzT4REGbFRr8PW+qEY8zytKqoiMoGLo=;
	b=jU4yOI/2RUkXDvb0Y4dQefoGJB3uvX6ffkspgdWBlFGvS1Uok8Rj00wyPcj03/VCoFrmup
	3pdGBFEVxlM5NUdn05WpYWYRfmolLd7hTKTvQqJP1+XLxfJwGtC4dlAztig6wrlHSNH/w5
	oCjk2CDrPJKpXWO138L4qRrYSCUIQf8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-4QD9n5ccNoqcmPjjx7_XIQ-1; Fri, 17 Jan 2025 17:27:45 -0500
X-MC-Unique: 4QD9n5ccNoqcmPjjx7_XIQ-1
X-Mimecast-MFC-AGG-ID: 4QD9n5ccNoqcmPjjx7_XIQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3862c67763dso1027953f8f.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 14:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737152864; x=1737757664;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wa0DMPdlPlQ3EzT4REGbFRr8PW+qEY8zytKqoiMoGLo=;
        b=mVRxbbPKmjX0aPAVv15+lW6yTD1TXIPXg1ZNtn6x9UrQXpmxgP3RMDFYjJK4Fo92r9
         LqOdcD15AdfJ29jDt+syt+u4Yd8poElJHB1QiRGYyHj+iiNJulHuvghMk+7mKKDoI9SJ
         De3gwCIXbZX8JHevZofJIgCAmHfWLFH8Lh3965sXoSaWX185+fqX/BCUTkqjfdjGX1r+
         FGRaE8R3w59Bs32vmytXDS2vsaSUXnj66QhPRr22lLSD5IFFqB63iHGiqrjwDeVlIWk3
         qwKl9LPGoaODtqi3Q+7xZ0o8mDV+BexCQZhsHn23TVzVewj2iA3eD2E63VnKFVg3Q4YC
         9ZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgIRJQCuMNpNSIVaHM+eCFHbKnkFreyb9JI8+lzYZlmJX2NdPKzvBtKEoqyEZ0tKl79ETwdWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjhYuTgrnq7z90qo8wghZ5mDc9TnCfiEXMUv+Z/8ZSp4zJITvT
	GOHnUp3kxT7Z+NUOTH5ZUui3k2vOa0zqIhXbHVIt9oVRBhZi2VhfMnVc8L+TKJLrTtaSGAH1V6u
	BVyus5bgFmn8LB5Xwzseozdlr9PQQMgzkoEyBFFUk5oFRp5SbCH6qDQ==
X-Gm-Gg: ASbGncup5zNgiv7egot9ca7zkVs5YLr9HucWVu0jISai3gSw1mAKDo7D9hEs5KqV1Kr
	mwAY6UfpbxT39RYgk/Cv80BeuNpTzHX2qsBFfh48tZiKrqrORLtIeE/Uj6gsErjZhgDNPx45y6O
	baf9zNoL/WnBh1MFjEOLAt51aTav9Udv0srw+m+YkK7h6sg5oqww6F/NaXBtjjrLTtah5S/F3x7
	IcFHPFl+6EceoTcD+OkLL5AsulZCGBOr2umJ9gH0ovvEgdZQQysRa3jK0ZWbc9Oopk+ZXb/rIOY
	w1p/3A==
X-Received: by 2002:a5d:5888:0:b0:38a:4b8b:c57a with SMTP id ffacd0b85a97d-38bf57a6e78mr5049913f8f.44.1737152864369;
        Fri, 17 Jan 2025 14:27:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgsqGs0eBTicGZ0c/NUkNMdGgieSa64DsriG+QUy1VuXSGZh78FVPqac2yNWP+LB5UeoG3qA==
X-Received: by 2002:a5d:5888:0:b0:38a:4b8b:c57a with SMTP id ffacd0b85a97d-38bf57a6e78mr5049904f8f.44.1737152864017;
        Fri, 17 Jan 2025 14:27:44 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf328dc08sm3511447f8f.101.2025.01.17.14.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:27:41 -0800 (PST)
Date: Fri, 17 Jan 2025 23:27:39 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: jmaloy@redhat.com, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, passt-dev@passt.top, lvivier@redhat.com,
 dgibson@redhat.com, Menglong Dong <menglong8.dong@gmail.com>,
 eric.dumazet@gmail.com
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
Message-ID: <20250117232739.1b7e3554@elisabeth>
In-Reply-To: <CANn89i+Ks52JVTBsMFQBM4CqUR4cegXhbSCH77aMCqFpd-S_1A@mail.gmail.com>
References: <20250117214035.2414668-1-jmaloy@redhat.com>
	<CANn89i+Ks52JVTBsMFQBM4CqUR4cegXhbSCH77aMCqFpd-S_1A@mail.gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[Fixed Cc: for Menglong Dong, this is a reply to:
 https://lore.kernel.org/all/CANn89i+Ks52JVTBsMFQBM4CqUR4cegXhbSCH77aMCqFpd=
-S_1A@mail.gmail.com/]

On Fri, 17 Jan 2025 23:09:27 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Fri, Jan 17, 2025 at 10:40=E2=80=AFPM <jmaloy@redhat.com> wrote:
>
> > v1: -Posted on Apr 6, 2024 =20
>=20
> Could you post the link, this was a long time ago and I forgot the contex=
t.

https://lore.kernel.org/all/20240406182107.261472-1-jmaloy@redhat.com/#r

--=20
Stefano


