Return-Path: <netdev+bounces-197259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A82AAD7F94
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46207188A7CF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054E1B414A;
	Fri, 13 Jun 2025 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ywYKn3V+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4E219E0
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749774069; cv=none; b=RkMp4Mj4D88+AJMvdMBs7oHRmY0xea26EY8FOOkolg2PhNytzjqcqjMkPoN55dvYLQb06/YPEbrPkWVju/Eu/lwVCqkFTkBei91X5zdoHneQZsPSas7XKbF+u/KQ638kg8/y9n81tILjvD2U3Tqp3cElLkx+JMSQ4xw0XvXF+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749774069; c=relaxed/simple;
	bh=6oxAFf4++bRIonZ3ootT1Dvf/Qx41GTg5N6Oburkl5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdKTfYSgPD+lvLh2nILRY2xkwlGQOCc3ImEvQ69uix9crV/0wGFxk03NLvT6q2AnjWiZ29RqEe1V/LQ/1X6l95vZLKsEgofU6u4dAzYGl6n3JPge9LPPeCnWpWWJ/1hZxVKuGjlLYwXLCoRDps6W1X+tJajtAEqMlj6NN+WHdN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ywYKn3V+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5536b9be5f6so1298232e87.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 17:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749774066; x=1750378866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oxAFf4++bRIonZ3ootT1Dvf/Qx41GTg5N6Oburkl5w=;
        b=ywYKn3V+d1F7Gon0NEKBwIHkHZmx68UG+OubeajPSYho51ssqDtuEwBlgyU/L9kE6a
         rZrMqHRzwyh83mXDgviLWQY1g9oyN1iPR64e7jmZPzfbw2wXOOr2q/iLlKQTRcAHf5Ni
         5wVb1GC4lGFKonw5hfvXxnQs5lh8uzDAle+eLRUwYBPbJxocPpA3yQA43uK8lRoVFdU4
         4LIvp0QPsPmajnORLPr/jZRLZlfeQ5FbBv+sLLpSAAJC9gUC9smcpedX90+MuEHWY939
         B0P31iS795Jg1ynmYGwyOPNqmCF9YU3XhMM9h97ytXJIqs582OHjfXrUtiyACqn9dkyd
         thoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749774066; x=1750378866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oxAFf4++bRIonZ3ootT1Dvf/Qx41GTg5N6Oburkl5w=;
        b=ti02lVaphWnK0eNdYWrFl67M8bISKorZfgUHY8jQ5W9hLmu+0r2FDErQp+8pl56uLU
         qD0mT58OwvQ5xS+kPpo3LoYNgb2h0Y+cCa7BQbHiQ3EoBHgbdSYJUBQqCCxtwpAfIv90
         s8dpp30mBsdFmuMvv+jPeya2ZFg9XspZa+/8UpNsH8gR7l792gs0Xtg5zFhhfJ9DlqF0
         MIxwtA+eWmGXKXlTpZB4wvolitbZYDvFNbVCO9mbFkz4sExGQZTenGIyFmQjqfI8iUB/
         Z+ik0SaY7AWBPz88caVH3b06SY8tVxElR6prbZ54m/ZdgfMG0TxENBwITQlVtJ1N00E/
         7lAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7CPWK8ENTezZWdZ3Q/WhimahvMeh1Tdk4VYa1zx7EnPpM7SNHWw/ppyWWS4xGBwlt4qOwvDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ckwR8+gfgagaN0T9RUZBgUsZaT8N5RCiPWRRN+Hz+yj52hbn
	41C3Koky4hBjWT5xsiiNHTpDrcjhrSaUcFSMyMsq9R0f1/QipsIG3dd1ldF2bsbu+GpZ15E6lRt
	Uusxm2STaeJ4TER+lnsLuc9UtKVCL9l1DEimFfPyb6P8zHNvpAmie8js=
X-Gm-Gg: ASbGncuB14enzvT3E24QuG1QCC/LFb77aT+cmMMU/HXtwp8CGl0PoH0RpSo/WC4vPKZ
	rIvfglYphBH601PWI8B5cUukRqSrN4VV+28thXN7ugHVrdKL8HFcFyeE5zxiJKe6/Yza4zU+hDN
	aOTSUUJ+zR5rcF26i32/Uk8cvjOlgQyb3PLnPcGosQm/0JuDnWWnXniIOw4vvAM0K2foR2kojm
X-Google-Smtp-Source: AGHT+IGw36e7JsZbFXkPUbj7QsFJ7rhNdm3CEYKxP5q6L5ZJam/GXA6wfFRPajbARbP+m8y4DU/kklMEa0reYoZq27w=
X-Received: by 2002:a05:6512:b8c:b0:553:522f:61c9 with SMTP id
 2adb3069b0e04-553af90d703mr258113e87.1.1749774065557; Thu, 12 Jun 2025
 17:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519082042.742926976@linutronix.de> <20250519083026.095637820@linutronix.de>
In-Reply-To: <20250519083026.095637820@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Jun 2025 17:20:54 -0700
X-Gm-Features: AX0GCFsrStyANSXghA2ujjwfGv8KljcDGy-5euaxgQLidATlo8os2dJMHAEh1WE
Message-ID: <CANDhNCpBfEYadVAmBj5_AsFU=TDUGc5bKMAKm5=ZLyTmkjB+pw@mail.gmail.com>
Subject: Re: [patch V2 08/26] ntp: Rename __do_adjtimex() to ntp_adjtimex()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
	Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 1:33=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Clean up the name space. No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

