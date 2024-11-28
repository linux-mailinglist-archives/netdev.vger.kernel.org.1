Return-Path: <netdev+bounces-147671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DDC9DB0C0
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 02:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F63B209A1
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 01:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1667418E20;
	Thu, 28 Nov 2024 01:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHlcIDwZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4117BA5;
	Thu, 28 Nov 2024 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757660; cv=none; b=gZaXHo7Z9SFbxobcMffgK+ha4a3u2NIxnEsdmsg/c4Yl6GP/bGapLlcOasYgR8Pexw6JDKW3e68koUn20d6t1FT5iGuizRGCozcBBKvtlf9dNJplkf9j3rsugwfRAuKJmZXa8kIatTBmk8VbA15sEvT+hX8yJ1N1sjHOtMwQ3HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757660; c=relaxed/simple;
	bh=U/6WQIU4a//kKrB5YNJNkG98yC8cGO7xOd3yOhJOaxM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwIrgM5VLi19SQYR1iInnyPDCytXw5/dBMnV8UoHucitgfEogc9QF8eCnr3W3Xq4aVQBO1CiKU6/K7opz3xdwH3x92YCjE6Pxahv/46PMFyDOqtEx+rYF3YOf5Z8ADZuHIHapaMP3UeqRttFWJn0j5DukzHkue25UyZEwwZywCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHlcIDwZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fbc1ca1046so254646a12.0;
        Wed, 27 Nov 2024 17:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732757656; x=1733362456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5Li4C3vYc2uhIimV+y7MuYAtqMbY3oqcy0i28EPpUo=;
        b=bHlcIDwZTVCzoO7vwKVtlojxSMb4IDEAFzJtfJOOEWCgllfidDR5FV41Kx7YwBnYAQ
         lwHYzRnqJeryam2r8HPs1QnYNI8QVxVuMmVJQckP+VDeEekUM0eskE6OKQ1nkOoAxlhW
         n9oVtzWBr24aT5Uy+oOD2G6EiQy7kxDmdnJtMkpzcfOAaq1CcJOjYgvWgfzYVJFDlMK2
         4g1yevc0RaUh2Qe4c90mOO79Tl4waecsN20Isg5WpAio9Y9UnZQXSO9EsGn8NSXWtwX9
         Cen1WIEM1/jQliJbqepJEklpwpOxp6SKVvn1ETbsoTXG6IdpzfxQ0pUX4XtgvcziWI7+
         7z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757656; x=1733362456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a5Li4C3vYc2uhIimV+y7MuYAtqMbY3oqcy0i28EPpUo=;
        b=pQc+TFWAdCCZoNDc5UWxo3hSznlwPv7qdOKoEP2PbYoKdaxCjBKVkZfTmXtT4Te0tu
         j9mNUL4RCClYcJ0yOT9IVniupbijdR48suEViLsjoU5gsQn4ffuOwt4ep62zGk/VtK9n
         Jcuocw46+pEjOc9YEsZWNle1muXhLtS5YuYMHpz7628jBlGetu4WR6jvdk0z40NcN7No
         drDho20mNId1L7JTz12wpV6spq4w9tk5WTlWTZyZxAfYJZAFxewg/VONLlNbLnv5/Kzl
         mvTBg+jvAjFtckUST0qjrSWihEAtkDZr3pLXUTItBiRESzhTKGJvf6arWNZ7U0bdHttI
         c3xw==
X-Forwarded-Encrypted: i=1; AJvYcCU+mqMmmdpw5kgysPAOcePbViGr77gJ5kJrIDwbJqyYUroQW0ydmamEkJaSAIdSMTz7a6czLdiY@vger.kernel.org, AJvYcCVZBi9ICg+fUOIyXnI0pJOjVOgKGDJicToiIaHBEULFpsLMA4XyRP72559OktFReA5EIJVF7b6TDR17SeyZ@vger.kernel.org, AJvYcCW6HsEJq80277/tQxw5+LphYJG08rgbmusm6IFPf2xPL4x2s25S9SgW7pb5QsB6U0KyYmy7cZTNpeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kpGfO2kubWuNRwbAXFWz1BrmJsWiOklz/aYiTQqLV4VpLMBE
	FTonAplsgbs4mewD2Ay1aCk4Mo44gw3MxiMtLSkhcKGG+6NMi7cS
X-Gm-Gg: ASbGncvKMbWUCR+5yhpytCWxoGKtNn4/8L+ktfhWuMTQMDzbzBz++vMlarVvV2OZq/G
	mv9Ye+cZcAQgGnMm8ONWKR8au3Dwpg5qO8cI/fItNTDYbqGphi/Ep2XG89UicAFFj6wZycLyRdB
	bhi3qeJuWVvbCvAuXiTF5b59Evbwj5AKP4yMfdM/WdHkVnTCvRfIBaJLD9zF7R9DdNiFAvVogUA
	yfRbjdiAjdWJ99YiFwav3r23YmJnSgc9U7blWGy2pbJaHAfzbRvz5XX8lEEggg=
X-Google-Smtp-Source: AGHT+IH207gYbSo+xat5bkqubqV1MvEJB/cayg6nxW1RQqOBVs0WnbDqfCltA6JUpyy67naQzMmuiA==
X-Received: by 2002:a05:6a20:734a:b0:1e0:d1f7:9437 with SMTP id adf61e73a8af0-1e0e0b80369mr6775480637.38.1732757656483;
        Wed, 27 Nov 2024 17:34:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbab6sm249343b3a.106.2024.11.27.17.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 17:34:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Nov 2024 17:34:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	edumazet@google.com, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, pcnet32@frontier.com
Subject: Re: [net-next v6 5/9] net: napi: Add napi_config
Message-ID: <f2cb7502-4fe7-4803-a6e6-674280120235@roeck-us.net>
References: <20241011184527.16393-1-jdamato@fastly.com>
 <20241011184527.16393-6-jdamato@fastly.com>
 <85dd4590-ea6b-427d-876a-1d8559c7ad82@roeck-us.net>
 <Z0dqJNnlcIrvLuV6@LQ3V64L9R2>
 <f04406c5-f805-4de3-8a7c-abfdfd91a501@roeck-us.net>
 <Z0fEm2EmZ6q1c9Mu@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0fEm2EmZ6q1c9Mu@LQ3V64L9R2>

On Wed, Nov 27, 2024 at 05:17:15PM -0800, Joe Damato wrote:
> 
> Guenter: would you mind sending me your cocci script? Mostly for
> selfish reasons; I'd like to see how you did it so I can learn more
> :) Feel free to do so off list if you prefer.
> 
You mean because it is so clumsy ? :-). No worries, I attached
it below. It is way too complicated, but it was good enough
for a quick hack.

> I tried to write my first coccinelle script (which you can find
> below) that is probably wrong, but it attempts to detect:
>   - interrupt routines that hold locks
>   - in drivers that call napi_enable between a lock/unlock
> 
> I couldn't figure out how to get regexps to work in my script, so I
> made a couple variants of the script for each of the spin_lock_*
> variants and ran them all.

I pretty much did the same, only in one script.

> 
> Only one offender was detected: pcnet32.
> 

Your script doesn't take into account that the spinlock may have been
released before the call to napi_enable(). Other than that it should
work just fine. I didn't try to track the interrupt handler because
tracking that through multiple functions can be difficult.

Thanks,
Guenter

---
virtual report

@f1@
identifier flags;
position p;
expression e;
@@

<...
    spin_lock_irqsave@p(e, flags);
    ... when != spin_unlock_irqrestore(e, flags);
    napi_enable(...);
    ... when any
    spin_unlock_irqrestore(e, flags);
...>

@f2@
position p;
expression e;
@@

<...
    spin_lock_irq@p(e);
    ... when != spin_unlock_irq(e);
    napi_enable(...);
    ... when any
    spin_unlock_irq(e);
...>

@f3@
position p;
expression e;
@@

<...
    spin_lock@p(e);
    ... when != spin_unlock(e);
    napi_enable(...);
    ... when any
    spin_unlock(e);
...>

@script:python@
p << f1.p;
@@

print("napi_enable called under spin_lock_irqsave from %s:%s" % (p[0].file, p[0].line))

@script:python@
p << f2.p;
@@

print("napi_enable called under spin_lock_irq from %s:%s" % (p[0].file, p[0].line))

@script:python@
p << f3.p;
@@

print("napi_enable called under spin_lock from %s:%s" % (p[0].file, p[0].line))

