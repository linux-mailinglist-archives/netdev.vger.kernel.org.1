Return-Path: <netdev+bounces-67601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF0F8443E0
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 17:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F5E286B7C
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789FD12AAD0;
	Wed, 31 Jan 2024 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="WCT+PVf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891012A17A
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717663; cv=none; b=m413zDYhq7QWaE5JppV6XNbhm1ugeojj+wXB4r1IMP9EjjDS25K1Upvta5Pa7dE9kjojx8RrvyQfn5rDw5AZAQsuq58qCp2SnclLkA6ciMgu4bYUo0sy/0JVk17j8/d4O//HR095od+zr3T8N1NaG6bYzL+Xn32noni+lsyXcFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717663; c=relaxed/simple;
	bh=qZP3fRKrPg5loztFm4zNQ/28zcqKGcVtJ3/PRUCVdhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvXFTWpIzUr9BRY5YWrysXo2ymVEdCQJpkgsSoB2lPMSB5AyHzFpaHMlQ35VvWIJt55bD8QLZGPltxDokAZtMqDrymONMrnwwysrmdRDGlKziJcZJ66NRBxcW+cfgo2dQ13OYUuAKGOz8vcGsglbommAyH56SOrsWBXAFR0urSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=WCT+PVf2; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8b519e438so3052568a12.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 08:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706717661; x=1707322461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7A1TB8N3yQhbgWBJdZdg8F69Sy3vFLNuwl0L5vpudw=;
        b=WCT+PVf2braNnzTYzNm9Grgj3ZS8B5FyXjESUQwFMdItu5fV2YwaerVRr9GPM09Kz4
         aE3zqssBv96KRY2E4gEzqOQx2AwJ18N4I+9aj4p6dy1F38F7g+a8PdwY1nuBAJeMelMR
         s0nEweEPdVhNaYb+J2q75isVMcSkDj+dp6ZqQajg/JJGTzWdIAMAi5hPKMlSJhUOvpQH
         1rgOx0iBDSlukTG7sVco6bSWtw/usUYVoNHcvxvVb18bNkuc4emv2qguitderYNJUtpB
         oOqqjEd62O5BIHqh+0ai1T7QLIUcqOagznGKquc1Wj1vHpamvOJl6zFMrOHz8hN1Sme/
         mxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706717661; x=1707322461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7A1TB8N3yQhbgWBJdZdg8F69Sy3vFLNuwl0L5vpudw=;
        b=NQ+f0Gh4jLReQNTl8xQO5ALFsIYCaUlGKnLGz9NZ/w4PF77CdEt3TsHhq4+WcWIe1n
         GArByAMivl8s2oTitGHQDbHw5IJEspiZT4yqgmVzThxTOUyEhZ2fvOOnTt4+wWW2fnKw
         wrrleLpQCWdqtt+fR80sinYZjirS/5piBVSvjSLlaWPhFitlo0dYVeDJ3k3RYQ/POtBz
         N0St7ZV51e6IBDZqqqKcOTHvtS+GL0n7d5ngwyoz/WvTQoxTvjkAT+RO42weWK8+heO0
         rDrim0yA1lsfgJFi8pBN7UQ3Vo2OhPidET1+hnvjjrudN8OPbwYY2mNxc1FPfGhyYbcP
         szHw==
X-Gm-Message-State: AOJu0YxIhZ28p+QkiWZZ3k6YkOhjkGRH5eqa5jwdLNJ1QZuzPmiINqli
	hQj19iCoM7OIhT6ib3FV/SfJPUHAmjNz5pmxpt7bbHHVkmD0Y8WH8jEip8NIFvs=
X-Google-Smtp-Source: AGHT+IHENm2tV7+paHg3McLmt7LEnklXPl8lOHwCf8UlK5SR+rf4llEkV3VGTKY+EpwSBwo8XjSNwA==
X-Received: by 2002:a05:6a20:e608:b0:19e:3648:335c with SMTP id my8-20020a056a20e60800b0019e3648335cmr1758419pzb.24.1706717660954;
        Wed, 31 Jan 2024 08:14:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVKk8aZcg3J8U7MxNLKUiJBDcihzEH3SespSI5oi1pkvpe+R4D9PsvQdIfYbj+FSVyiSAUK4TzCZHzongEO5AXejQ==
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id s1-20020a62e701000000b006dd815b57c3sm10049516pfh.31.2024.01.31.08.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 08:14:20 -0800 (PST)
Date: Wed, 31 Jan 2024 08:14:18 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, Denis Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH iproute2] ifstat: convert sprintf to snprintf
Message-ID: <20240131081418.72770d85@hermes.local>
In-Reply-To: <20240131124107.1428-1-dkirjanov@suse.de>
References: <20240131124107.1428-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 07:41:07 -0500
Denis Kirjanov <kirjanov@gmail.com> wrote:

> @@ -893,7 +893,7 @@ int main(int argc, char *argv[])
>  
>  	sun.sun_family = AF_UNIX;
>  	sun.sun_path[0] = 0;
> -	sprintf(sun.sun_path+1, "ifstat%d", getuid());
> +	snprintf(sun.sun_path+1, sizeof(sun.sun_path), "ifstat%d", getuid());

If you are changing the line, please add spaces around plus sign

p

