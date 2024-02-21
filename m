Return-Path: <netdev+bounces-73557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9CB85D0BA
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 07:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90FEFB24526
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 06:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC98364BC;
	Wed, 21 Feb 2024 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbJoYeOv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39ED3611B
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498562; cv=none; b=IPtnr5Tp5OAwPjKTxNCe2vG2v7A0pFwy+2YM6m0FeB2ajPzYDKhv/P8R6ttvi2ogOjPATffejdPJ/Td/hdAS4rKlUkLMZxdubQP+kMlum4cI1CWRIF/rwA7gAckDCGaahwQ9PK1os3cKXIFiUIS2R9nD3XR8yM/pXbEtlRu4kTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498562; c=relaxed/simple;
	bh=aAti4nMOwlYQnYODZYrZMH9XvmSJIK8VSux0OUhyCwo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aPHTRPz1xsj5nXFBD2/pIxBhJ+nTQpTAlc4NNLYPaA8h7tFgfvYwJzDn5VM1I5O+vBg3sh9ND1reVgElksOkLGgesP9T0btS8EavgmpPlBUFcBZOXOlnGMBIx61RHG67V3cagtMuKFFF2XzHzDoym1RMYt6tBpZZ3pDz0lhq+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbJoYeOv; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so315312276.2
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 22:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708498559; x=1709103359; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aAti4nMOwlYQnYODZYrZMH9XvmSJIK8VSux0OUhyCwo=;
        b=EbJoYeOvMQybZgVk8p6jjN9sMPe++YvzMYka3g8UkNOnSoKx+OHgnpcx5C8SEf6keQ
         KRS2/IAcunyv47+ntUTdLwjAzHHDUOCOh7sKk20EyUzI2ccfX7c79kuy+hVF2UjgU6lv
         C8tvXppZ8MQea41djOPnbE2fTBT4F6YPyi2GKE/1lZpfK2nx5J/j5XUONqRDxFRXsYbY
         cbFVnv5X9Mj41Jnj2tYJdPeDi95FaFQTqFrnD5ka3Jb21ZvkMzdeJlok9whstVshV7m4
         160g6exCNxVsuuyfRmuvTtiLlb9fkuibaTs72bTRBN3a3wCm0nQXJC5sgD7q63hHWAOy
         MoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708498559; x=1709103359;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAti4nMOwlYQnYODZYrZMH9XvmSJIK8VSux0OUhyCwo=;
        b=ruAHQUf9X19L3Fuairt7lSxH+d2c279439UF5U1+EzjQLfkvFV/LLKD2boxgzGjrXP
         gZjsvpAnkHbBcsVjgvBWenOG2wLKCwGDWwtkWUldmcdTQJrEtciASXlrb5aTkf5E0Mo8
         ap8I6mkm7QRRUTwH7Ss8jqLUhyyzQ8Anae21U4xIg/eyeZWzszLUDIndm0VXLXLokjqD
         LiI2Ug6xUrH+rxO1MRpuz4PuFj9d+NIiwzcSLmeoj8zNsbPq7CNxK0RIsIgDbL/z5ybP
         Uc4kn94X5ptyrXaJoVWLDGZmIvpi3/SfESQ9uc/I9RrlRzepCHOvlAxxuZAz+eL9sJ1U
         bYEQ==
X-Gm-Message-State: AOJu0YzsTM26SYeBvVTfg4/gGBMsBGJzTQw7yEnLX3lTATYXd6dRQNmL
	3g3hv4PYW17Cgy/hz7u6xtE64PwgivAiNthM51J/aWsI8UmNckmTFRMoW8IePA01WfRgwgSK/7W
	h/tT6ijVqTcykm8/l/P2C0vS48ODdsxRLYSkrn3lwILU=
X-Google-Smtp-Source: AGHT+IFffq2/j7dkzsOnoRIrd91RzjG8LQ3BiWPTaViz4eLeuOqy/Rj2ueLVZ200WroNMdXQVXuWXbyPjBE+bFBJvOg=
X-Received: by 2002:a05:6902:563:b0:dc7:32ae:f0a with SMTP id
 a3-20020a056902056300b00dc732ae0f0amr15947507ybt.65.1708498559622; Tue, 20
 Feb 2024 22:55:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kamran <kamiykamkar@gmail.com>
Date: Tue, 20 Feb 2024 22:55:49 -0800
Message-ID: <CAOb+SpYRmDpLYS2yePXs82PiuEqORXZuUVqFCWzYYtFp_7pfaQ@mail.gmail.com>
Subject: SO_ORIGINAL_DST socket option when doing redirect from nat table's
 OUTPUT chain
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Is SO_ORIGINAL_DST socket option set while redirecting traffic from
nat table's OUTPUT chain?
I am redirecting the outbound traffic of applications to a local proxy
server to first do some inspections in it, then redirect to the
original destination. But i get some error about there is no
SO_ORIGINAL_DST socket option.

Thanks for looking into this.

