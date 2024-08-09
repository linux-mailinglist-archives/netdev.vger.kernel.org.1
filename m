Return-Path: <netdev+bounces-117276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D330494D62F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 20:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A281C21665
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D2614883B;
	Fri,  9 Aug 2024 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WscQlzfi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7B2940D;
	Fri,  9 Aug 2024 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227402; cv=none; b=DWCepMaInBM5BT0xKffdwKfRnAqF1qTD+8XXrMnpA6nQEmDHR8XgyiObgaVVPW2pYFaHcs0TJ1165m1XnKV6H9Rod94i/b6xqBnMmstteh9dqwCeXh3ZALRWWapjkzRe6k+F4e784QaaPeCtGQ1czZ0HItdrTQ7PGYIIhOFxIUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227402; c=relaxed/simple;
	bh=fpvaw8DCnHrzRFGVIoPM/b/Pnw4YKFA+0tumI9p6N2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFUUiUptNPyxJME0dLVDpMWMtjBTVlIjvTGqRApmHPIKoj9A4r5Bzq4csmw8Dk1Yg6Ftq9JaOr7SPfdK7jZcSPcEIF8aFO19I4UxFYJ21RAGEKW6ymxRpskmiXH6zZTZx6qwfAUov3OMU5+v1oS/2KekcgV4FSHJV/lGMjSwDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WscQlzfi; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-710ce81bf7dso1487783b3a.0;
        Fri, 09 Aug 2024 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723227400; x=1723832200; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sGYCfVt5HUFKtCIyB2BVc/wP8dt4cWBhz43nVIBGIDE=;
        b=WscQlzfiIYV7SgDEieM0NHRLp3mTMpLzKSTBw1Hh8z1mK/oqknttsezULYGAOGAOiM
         4JLkOkSaBzpzoGDeNCQOLynWQnW5Wf/g+EmXiEsPH8J6YhoHx+31DZINwIi0q9R4eSOk
         4XEPgah6urXl2cBcUYt2rGfrEX3rzyWu5RWlXIx+tPHCg2UGKV2fsbx60M/JmDA4M9bk
         yli27iZ2nFQ7toLPDj1lM5Na0I3CUTIWQXc6p8xlxHC98IMHZKL6HnW5us0lUxWvTAIq
         DSYcMZ3FRj6apf4mmECm/GEZm0QSizYLeMh4k2IZO8DJmWNgAiLicbB44Faha6bsuGIH
         ySkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723227400; x=1723832200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGYCfVt5HUFKtCIyB2BVc/wP8dt4cWBhz43nVIBGIDE=;
        b=aekRd1ayJqn3MCQILC8KJrLJ8Pu4AYRDqjp/KmMEdJ3hdulAxC9q48KLfHWUGi+Wtb
         dTj4T9SmhsoL4U1LoJjjg8FYj+UYxD9WzymRHm4M0KuJojQb1xMmu+GIGnaCw+7MkglT
         GdK/EmiW0gQ+VvgUWeYGYaXZQLN3KQ09Mt3zK0u8qFlpLpGWuDt2q5orXGkLZAhprejg
         iLT/8IW0dJUaKFzNThl0MCt+ypq5dYXqgZem69fcQG4TKaHlu3h8zavtlvvTPQNc3fAD
         TDJQPLkF2CimDz6z39fNvvoXscqMaXm+oAOMEiLsFeVeE8qbqDrBJ5I4AOOPoWtMfYmw
         +zvw==
X-Forwarded-Encrypted: i=1; AJvYcCVyc2eWzuzMj/ef1WfKlZbY/nFFSMtmtvYErKV3xpqKO4zYOydkGpAZ55ZO02ZDtwb22tx6ku6qg2TqPFjtf1sV9h9wL5LW1wkG3IJINtkusIx2U1OrOXDnv4D6ZSldvlryGpOW6UIZIsXE6hOtAUuewn+x8vW490MMJaaQlx4CKJB1UPeN7F4jiPui
X-Gm-Message-State: AOJu0YwVooP56ficFODPyEa1bZCDrg4omMez30UFTzqmKtFWWnXef7xQ
	/6+JL34go4KUk+2K4UKc7XhrmyZM1SvzuFZONTR5V3mAqpXdzLQU
X-Google-Smtp-Source: AGHT+IF1jV8DANk9iQuIkKGS0wN5OseqccVSfh3F1SU4PO2hoGUw4n7h33eWSRiZ7XHTE/v9XlMR8Q==
X-Received: by 2002:a05:6a20:c792:b0:1c0:f5be:a3ca with SMTP id adf61e73a8af0-1c89ff823eamr3116505637.30.1723227400171;
        Fri, 09 Aug 2024 11:16:40 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fbaf3sm508775ad.183.2024.08.09.11.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:16:39 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:16:37 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com, jannh@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH v8 3/4] sample/Landlock: Support abstract unix socket
 restriction
Message-ID: <ZrZdBZUMnCd81pY3@tahera-OptiPlex-5000>
References: <cover.1722570749.git.fahimitahera@gmail.com>
 <2b1ac6822d852ea70dd2dcdf41065076d9ee8028.1722570749.git.fahimitahera@gmail.com>
 <20240809.uupaip5Iepho@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240809.uupaip5Iepho@digikod.net>

On Fri, Aug 09, 2024 at 04:11:47PM +0200, Mickaël Salaün wrote:
> On Thu, Aug 01, 2024 at 10:02:35PM -0600, Tahera Fahimi wrote:
> > A sandboxer can receive the character "a" as input from the environment
> > variable LL_SCOPE to restrict the abstract unix sockets from connecting
> > to a process outside its scoped domain.
> > 
> > Example
> > =======
> > Create an abstract unix socket to listen with socat(1):
> > socat abstract-listen:mysocket -
> > Create a sandboxed shell and pass the character "a" to LL_SCOPED:
> > LL_FS_RO=/ LL_FS_RW=. LL_SCOPED="a" ./sandboxer /bin/bash
> > If the sandboxed process tries to connect to the listening socket
> > with command "socat - abstract-connect:mysocket", the connection
> > will fail.
> > 
> > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > 
> > ---
> > v8:
> > - Adding check_ruleset_scope function to parse the scope environment
> >   variable and update the landlock attribute based on the restriction
> >   provided by the user.
> > - Adding Mickaël Salaün reviews on version 7.
> > 
> > v7:
> > - Adding IPC scoping to the sandbox demo by defining a new "LL_SCOPED"
> >   environment variable. "LL_SCOPED" gets value "a" to restrict abstract
> >   unix sockets.
> > - Change LANDLOCK_ABI_LAST to 6.
> > ---
> >  samples/landlock/sandboxer.c | 56 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 52 insertions(+), 4 deletions(-)
> > 
> > diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> > index e8223c3e781a..98132fd823ad 100644
> > --- a/samples/landlock/sandboxer.c
> > +++ b/samples/landlock/sandboxer.c
> > @@ -14,6 +14,7 @@
> >  #include <fcntl.h>
> >  #include <linux/landlock.h>
> >  #include <linux/prctl.h>
> > +#include <linux/socket.h>
> >  #include <stddef.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > @@ -22,6 +23,7 @@
> >  #include <sys/stat.h>
> >  #include <sys/syscall.h>
> >  #include <unistd.h>
> > +#include <stdbool.h>
> >  
> >  #ifndef landlock_create_ruleset
> >  static inline int
> > @@ -55,6 +57,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
> >  #define ENV_FS_RW_NAME "LL_FS_RW"
> >  #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
> >  #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
> > +#define ENV_SCOPED_NAME "LL_SCOPED"
> >  #define ENV_DELIMITER ":"
> >  
> >  static int parse_path(char *env_path, const char ***const path_list)
> > @@ -184,6 +187,38 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
> >  	return ret;
> >  }
> >  
> > +static bool check_ruleset_scope(const char *const env_var,
> > +				struct landlock_ruleset_attr *ruleset_attr)
> > +{
> > +	bool ret = true;
> > +	char *env_type_scope, *env_type_scope_next, *ipc_scoping_name;
> > +
> > +	ruleset_attr->scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
> 
> Why always removing the suported scope?
> What happen if ABI < 6 ?
Right, I will add this check before calling chek_ruleset_scope function.

> > +	env_type_scope = getenv(env_var);
> > +	/* scoping is not supported by the user */
> > +	if (!env_type_scope)
> > +		return true;
> > +	env_type_scope = strdup(env_type_scope);
> > +	unsetenv(env_var);
> > +
> > +	env_type_scope_next = env_type_scope;
> > +	while ((ipc_scoping_name =
> > +			strsep(&env_type_scope_next, ENV_DELIMITER))) {
> > +		if (strcmp("a", ipc_scoping_name) == 0) {
> > +			ruleset_attr->scoped |=
> > +				LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
> 
> There are two issues here:
> 1. this would not work for ABI < 6
> 2. "a" can be repeated several times, which should probably not be
>    allowed because we don't want to support this
>    unspecified/undocumented behavior.
For the second note, I think even if the user provides multiple "a"
(something like "a:a"), It would not have a different effect (for now).
Do you suggest that I change this way of handeling this environment
variable or add documents that mention this note?
> 
> > +		} else {
> > +			fprintf(stderr, "Unsupported scoping \"%s\"\n",
> > +				ipc_scoping_name);
> > +			ret = false;
> > +			goto out_free_name;
> > +		}
> > +	}
> > +out_free_name:
> > +	free(env_type_scope);
> > +	return ret;
> > +}
> > +
> >  /* clang-format off */
> >  
> >  #define ACCESS_FS_ROUGHLY_READ ( \
> > @@ -208,7 +243,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
> >  
> >  /* clang-format on */
> >  
> > -#define LANDLOCK_ABI_LAST 5
> > +#define LANDLOCK_ABI_LAST 6
> >  
> >  int main(const int argc, char *const argv[], char *const *const envp)
> >  {
> > @@ -223,14 +258,15 @@ int main(const int argc, char *const argv[], char *const *const envp)
> >  		.handled_access_fs = access_fs_rw,
> >  		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
> >  				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
> > +		.scoped = LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
> >  	};
> >  
> >  	if (argc < 2) {
> >  		fprintf(stderr,
> > -			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\"%s "
> > +			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s "
> >  			"<cmd> [args]...\n\n",
> >  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> > -			ENV_TCP_CONNECT_NAME, argv[0]);
> > +			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
> >  		fprintf(stderr,
> >  			"Execute a command in a restricted environment.\n\n");
> >  		fprintf(stderr,
> > @@ -251,15 +287,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
> >  		fprintf(stderr,
> >  			"* %s: list of ports allowed to connect (client).\n",
> >  			ENV_TCP_CONNECT_NAME);
> > +		fprintf(stderr, "* %s: list of restrictions on IPCs.\n",
> > +			ENV_SCOPED_NAME);
> >  		fprintf(stderr,
> >  			"\nexample:\n"
> >  			"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
> >  			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
> >  			"%s=\"9418\" "
> >  			"%s=\"80:443\" "
> > +			"%s=\"a\" "
> >  			"%s bash -i\n\n",
> >  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> > -			ENV_TCP_CONNECT_NAME, argv[0]);
> > +			ENV_TCP_CONNECT_NAME, ENV_SCOPED_NAME, argv[0]);
> >  		fprintf(stderr,
> >  			"This sandboxer can use Landlock features "
> >  			"up to ABI version %d.\n",
> > @@ -327,6 +366,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
> >  		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
> >  		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
> >  
> > +		__attribute__((fallthrough));
> > +	case 5:
> > +		/* Removes LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET for ABI < 6 */
> > +		ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
> >  		fprintf(stderr,
> >  			"Hint: You should update the running kernel "
> >  			"to leverage Landlock features "
> > @@ -358,6 +401,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
> >  			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
> >  	}
> >  
> > +	if (!check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr)) {
> 
> You should use the same pattern as for TCP access rigths: if the
> environment variable is not set then remove the ruleset's scopes.
I think this happens in check_ruleset_scope function. However, I will
add a condition (abi >=6) to this "if" statement.

> > +		perror("Unsupported IPC scoping requested");
> > +		return 1;
> > +	}
> > +
> >  	ruleset_fd =
> >  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> >  	if (ruleset_fd < 0) {
> > -- 
> > 2.34.1
> > 
> > 

