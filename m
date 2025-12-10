Return-Path: <netdev+bounces-244279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3AFCB3B92
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 19:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 120AE300BDA9
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 18:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B7831062E;
	Wed, 10 Dec 2025 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIkVp+Pj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA9192D97
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765390438; cv=none; b=PaikVDjO7N4daN4oqiqyKC9a3UVVbYzUEzK80NB9hmFG9Iq6soU8L4ZU6jwrA/Ou4unUahwVb9vbKtpZ/qbWJYQecOl7YD+3IMzKMCeyylMtIcdz9JCuWxUYptCN1BDx+VXLRDginZRjzisHOya9mpV2t69ZEIJcVVZfqoolZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765390438; c=relaxed/simple;
	bh=Wtn11a9iEnf43J1eX/LK36QsqtWTGu7jL2VTy9DfQB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q95H66QKlVNTyvZHCsIqVlfBvGCYBuUg+LnsrZFXo69tsVDrkP4TNMVDnXt5TdZs9kpVEEHPif3TtTuaCf2NtWNqe85O4zr5y5JxsGbUNTO0qWVMfTMpPJwHiptmDQ+7DWGBcsS4oTtfdQw0+nC9GntJJwfNWt7thbbtW2m26aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIkVp+Pj; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78c35dc5806so1212547b3.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 10:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765390436; x=1765995236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+csY2ByO8RttGedAiCGy1ilPBafiqYG3jRO+0XdJFE=;
        b=VIkVp+Pji01mIAVj9Vr920CctEdTk9D94QfCltJuceXWyYj0dSXoFef2nguNmTDYN8
         /Cezcl2RdJZ/30+7ja2DEKZXfqn0d2MWdofhX85HgD5wx5Zk3bWLQQTx+h6P5LONcs3H
         g4vIO3fwf6PHvgACRq/nOZ/4hkh8/y+wq3aw8RqTMTzPdlpKfu+3MdE2QSxEPZT0SEEk
         tLGET54KSmuTtSxwDN3n736pFf1fOLNwJjL93JofxGFd4NF7RYAtUBsYbHLV1Q174sKA
         4llpefqOqc7q06vChIuL2HL1lUKhTztNPOlbgOfn4frUfbqhlkIHRFWZ3lo6hJpkv8HA
         eksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765390436; x=1765995236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+csY2ByO8RttGedAiCGy1ilPBafiqYG3jRO+0XdJFE=;
        b=oFcUe4FPIx/ur+IRtopUSS0rR4HmP+SV5wS6R2mkax1EKGchWzGWH7WhSGKpuevuxj
         uYQlhUY2V2YB9b7/yFTOPKxjZ0AOySeFRYvugg2R3fEzVP4dwfyKFHKm5pJ/tfufqJ+x
         Ho3st6M5Gen2lAczUcQwsvrlxZGnz5Aybkksgh7bV1D88ao+mMu1rACJsX7pOZpffzdJ
         tfncF3gKCQRUTLP8J4u+owNTot+p6xxyY1l8kAJ2X1QJpbI+fAzWUGOvffvvOP69tX+r
         yTXEiesCAal48TZckzyj8biC1hfKwH8S4Gr7Ph9eIqALGq0SMj/9cIgGYlmqSlcXonCT
         jGmA==
X-Forwarded-Encrypted: i=1; AJvYcCU1LOozMxtRvaPGC9HLMD9jsxQsmIu00cCQAN6ldnNHm2BF4zdfILSTy49vCIDdQjIvFZ6VHOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7+EejvjziJoRp65W1rq80Do6Va3jze4soaxehkinYMPCJvD6
	zuXZmqmXIK06/UJnL3icXTEgB+Q9iEI01avlqQm4jVoqVEVfhsdqByWV
X-Gm-Gg: AY/fxX5ERUnevuAeF+dzMQTffi+xawQ2LdMlLdqX4QRtrNx9jlsZdB3lINdb5LlqOeD
	xBGJXLzg5eB06VsTbvaWSKe7AT7LLQsB/gZ6B+yYXP+4A0GR+c6wSCt2LP8fvEgUI/QbTv2a7GV
	H/vOnaA6gbteW0iCQ9QPOzaTxsSoTOuw5Z2kx4uE2YmUyhDLY4z4+uAfM+03rnH+n7d8hhR/ci9
	NBupTM6MQGGa7Bdeu3Bl9krDC7zFSLMDf6SbwpIX31QuHWb007aK2cjL3WwJzpTmaaWKwavF3X5
	YyQh5IPyBT2w025uDh6bQ7lEfujKjaasyNcQxEeqyNLogEf66tf1n4vzqlVUHm+/0HpTLnvDnUu
	ojfMphjUFIshtcNWp1q0ezj3K2PfdEA8rQCf0OzWQAT7pIOUUMwlqzS7Y0CwrnDG0S5F66DrREZ
	QlQDgCEoM=
X-Google-Smtp-Source: AGHT+IFNQ+uuN8jF42ubdJrRT5xIjGkXIwoFJdbKXMVHKukzaq26xU+wZQxTC29eXTthtXTon21EyQ==
X-Received: by 2002:a05:690e:1287:b0:63f:b4ee:792c with SMTP id 956f58d0204a3-6446e9116famr2757099d50.19.1765390436050;
        Wed, 10 Dec 2025 10:13:56 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:74ed:2211:108a:e77a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477dab6f4sm149212d50.12.2025.12.10.10.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 10:13:55 -0800 (PST)
Date: Wed, 10 Dec 2025 13:13:55 -0500
From: Yury Norov <yury.norov@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Crt Mori <cmo@melexis.com>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@netronome.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 2/9] thunderblot: Don't pass a bitfield to FIELD_GET
Message-ID: <aTm4Y-avX8qoLLoe@yury>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
 <20251209100313.2867-3-david.laight.linux@gmail.com>
 <20251210055617.GD2275908@black.igk.intel.com>
 <20251210093403.5b0f440e@pumpkin>
 <20251210094102.GF2275908@black.igk.intel.com>
 <20251210101842.022d1a99@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210101842.022d1a99@pumpkin>

On Wed, Dec 10, 2025 at 10:18:42AM +0000, David Laight wrote:
> On Wed, 10 Dec 2025 10:41:02 +0100
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > On Wed, Dec 10, 2025 at 09:34:03AM +0000, David Laight wrote:
> > > On Wed, 10 Dec 2025 06:56:17 +0100
> > > Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > >   
> > > > $subject has typo: thunderblot -> thunderbolt ;-)
> > > > 
> > > > On Tue, Dec 09, 2025 at 10:03:06AM +0000, david.laight.linux@gmail.com wrote:  
> > > > > From: David Laight <david.laight.linux@gmail.com>
> > > > > 
> > > > > FIELD_GET needs to use __auto_type to get the value of the 'reg'
> > > > > parameter, this can't be used with bifields.
> > > > > 
> > > > > FIELD_GET also want to verify the size of 'reg' so can't add zero
> > > > > to force the type to int.
> > > > > 
> > > > > So add a zero here.
> > > > > 
> > > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > > > ---
> > > > >  drivers/thunderbolt/tb.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> > > > > index e96474f17067..7ca2b5a0f01e 100644
> > > > > --- a/drivers/thunderbolt/tb.h
> > > > > +++ b/drivers/thunderbolt/tb.h
> > > > > @@ -1307,7 +1307,7 @@ static inline struct tb_retimer *tb_to_retimer(struct device *dev)
> > > > >   */
> > > > >  static inline unsigned int usb4_switch_version(const struct tb_switch *sw)
> > > > >  {
> > > > > -	return FIELD_GET(USB4_VERSION_MAJOR_MASK, sw->config.thunderbolt_version);
> > > > > +	return FIELD_GET(USB4_VERSION_MAJOR_MASK, sw->config.thunderbolt_version + 0);    
> > > > 
> > > > Can't this use a cast instead? If not then can you also add a comment here
> > > > because next someone will send a patch "fixing" the unnecessary addition.  
> > > 
> > > A cast can do other (possibly incorrect) conversions, adding zero is never going
> > > to so any 'damage' - even if it looks a bit odd.
> > > 
> > > Actually, I suspect the best thing here is to delete USB4_VERSION_MAJOR_MASK and
> > > just do:
> > > 	/* The major version is in the top 3 bits */
> > > 	return sw->config.thunderbolt_version > 5;  
> > 
> > You mean 
> > 
> > 	return sw->config.thunderbolt_version >> 5;
> > 
> > ?
> > 
> > Yes that works but I prefer then:
> > 
> > 	return sw->config.thunderbolt_version >> USB4_VERSION_MAJOR_SHIFT;
> 
> I've put that in for the next version (without the comment line).

FIELD_GET() is here exactly to let people to not opencode this
error-prone bit manipulation. So, let's continue using it.

David, can you explain in details why this code needs to be fixed? Why
and when typecast wouldn't work so that you have to use an ugly '+0'
hack, or even drop the FIELD_GET().

My current understanding is that the existing FIELD_GET()
implementation works well with any data types, including bitfields,
and what you suggested in this series - does not.

If it's correct, I don't think that switching to your version is
well-justified.

Thanks,
Yury

