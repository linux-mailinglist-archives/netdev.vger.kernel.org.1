Return-Path: <netdev+bounces-132104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096C7990713
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2973E1C20A5C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CA5158534;
	Fri,  4 Oct 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XEXvz92t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565C1D9A4F;
	Fri,  4 Oct 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054275; cv=none; b=U2fnmY1qvEgi76MRzeiDnyNdaWwLTtgj3HB0z08keKcMmz8g6vBMxVMJf+fr28EJWqnDNQlS96UzlA6gSeKLmIVyPzSPmWnyLEjJQ0osvSh+jEHyDkyLm98fUZ35ArEcOd4GvQpBvOiAi3UglBkuw+sl3l5cIRcSNpwulk9ioqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054275; c=relaxed/simple;
	bh=lT0XRAqjOTPeWuN8bb0XCVgCD/rTTCENAWcimJ8sjxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSMxSu3XZZhyVRIauV53GyE54XzzHEW5+UHio6zNBB3+Mr+q+kqZ2HqY/zdnydlHGyDZHuHRzpTRzyFqAk7wtbGqII9nQdo1cVlgFnoVSylRyO26+c7LxvGGi/CC/fJKef7KluK4K/jcvoMUhOjh9+L9DhLPendtvkQIFlV+GsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XEXvz92t; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XKsJr2VQgzC1c;
	Fri,  4 Oct 2024 17:04:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728054268;
	bh=iSe7t8jGuIY2A3QPYUnH1aJ3yZ/co8bw8960T0QeURI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XEXvz92t+oY93jUSeepGVYDlD/holMGvGGDjbGDW5VZv+z9SAYrcBpTC3rYL+th5w
	 X/ugZKUtvxpYnwtguwP3ZXObApgh7o2ItwX0zxet5GQkmSQ1cr2nhw1py3NjnfjebZ
	 OlvMuX3OfyebkK6f0qhT2MaGxffbfYuPod+4PNwk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XKsJp6q1hz630;
	Fri,  4 Oct 2024 17:04:26 +0200 (CEST)
Date: Fri, 4 Oct 2024 17:04:23 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Subject: Re: [RFC PATCH v1 5/7] samples/landlock: Add sandboxer UDP access
 control
Message-ID: <20241004.ohc2aeYei1oo@digikod.net>
References: <20240916122230.114800-1-matthieu@buffet.re>
 <20240916122230.114800-6-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916122230.114800-6-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

On Mon, Sep 16, 2024 at 02:22:28PM +0200, Matthieu Buffet wrote:
> Add environment variables to control associated access rights:
> (each one takes a list of ports separated by colons, like other
> list options)
> 
> - LL_UDP_BIND
> - LL_UDP_CONNECT
> - LL_UDP_RECVMSG
> - LL_UDP_SENDMSG
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  samples/landlock/sandboxer.c | 88 ++++++++++++++++++++++++++++++++----
>  1 file changed, 80 insertions(+), 8 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 08704504dc51..dadd30dad712 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -55,6 +55,10 @@ static inline int landlock_restrict_self(const int ruleset_fd,
>  #define ENV_FS_RW_NAME "LL_FS_RW"
>  #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
>  #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
> +#define ENV_UDP_BIND_NAME "LL_UDP_BIND"
> +#define ENV_UDP_CONNECT_NAME "LL_UDP_CONNECT"
> +#define ENV_UDP_RECVMSG_NAME "LL_UDP_RECVMSG"
> +#define ENV_UDP_SENDMSG_NAME "LL_UDP_SENDMSG"
>  #define ENV_DELIMITER ":"
>  
>  static int parse_path(char *env_path, const char ***const path_list)
> @@ -219,7 +223,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  
>  /* clang-format on */
>  
> -#define LANDLOCK_ABI_LAST 5
> +#define LANDLOCK_ABI_LAST 6
>  
>  static void print_help(const char *prog)
>  {
> @@ -247,11 +251,25 @@ static void print_help(const char *prog)
>  		"to allow nothing, e.g. %s=\"\"):\n",
>  		ENV_TCP_BIND_NAME);
>  	fprintf(stderr,
> -		"* %s: list of ports allowed to bind (server).\n",
> +		"* %s: list of TCP ports allowed to bind (server)\n",
>  		ENV_TCP_BIND_NAME);
>  	fprintf(stderr,
> -		"* %s: list of ports allowed to connect (client).\n",
> +		"* %s: list of TCP ports allowed to connect (client)\n",
>  		ENV_TCP_CONNECT_NAME);
> +	fprintf(stderr,
> +		"* %s: list of UDP ports allowed to bind (client: set as "
> +		"source port/server: listen on port)\n",
> +		ENV_UDP_BIND_NAME);
> +	fprintf(stderr,
> +		"* %s: list of UDP ports allowed to connect (client: set as "
> +		"destination port/server: only receive from one client)\n",
> +		ENV_UDP_CONNECT_NAME);
> +	fprintf(stderr,
> +		"* %s: list of UDP ports allowed to send to (client/server)\n",
> +		ENV_UDP_SENDMSG_NAME);
> +	fprintf(stderr,
> +		"* %s: list of UDP ports allowed to recv from (client/server)\n",
> +		ENV_UDP_RECVMSG_NAME);
>  	fprintf(stderr,
>  		"\n"
>  		"Example:\n"
> @@ -259,9 +277,12 @@ static void print_help(const char *prog)
>  		"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
>  		"%s=\"9418\" "
>  		"%s=\"80:443\" "
> +		"%s=\"0\" "
> +		"%s=\"53\" "
>  		"%s bash -i\n\n",
>  		ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
> -		ENV_TCP_CONNECT_NAME, prog);
> +		ENV_TCP_CONNECT_NAME, ENV_UDP_RECVMSG_NAME,
> +		ENV_UDP_SENDMSG_NAME, prog);
>  	fprintf(stderr,
>  		"This sandboxer can use Landlock features "
>  		"up to ABI version %d.\n",
> @@ -280,7 +301,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  	struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = access_fs_rw,
>  		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
> -				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +				      LANDLOCK_ACCESS_NET_CONNECT_TCP |
> +				      LANDLOCK_ACCESS_NET_BIND_UDP |
> +				      LANDLOCK_ACCESS_NET_CONNECT_UDP |
> +				      LANDLOCK_ACCESS_NET_RECVMSG_UDP |
> +				      LANDLOCK_ACCESS_NET_SENDMSG_UDP,
>  	};
>  
>  	if (argc < 2) {
> @@ -354,6 +379,14 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  			"provided by ABI version %d (instead of %d).\n",
>  			LANDLOCK_ABI_LAST, abi);
>  		__attribute__((fallthrough));

> +	case 5:
> +		/* Removes UDP support for ABI < 6 */
> +		ruleset_attr.handled_access_net &=
> +			~(LANDLOCK_ACCESS_NET_BIND_UDP |
> +			  LANDLOCK_ACCESS_NET_CONNECT_UDP |
> +			  LANDLOCK_ACCESS_NET_RECVMSG_UDP |
> +			  LANDLOCK_ACCESS_NET_SENDMSG_UDP);
> +		__attribute__((fallthrough));

This hunk should go just after the "scoped" field cleanup and before the
hint.  This way the hint is always printed if the current ABI is not the
last (known) one.  This hunk should then start with a fullthrough
attribute.

>  	case LANDLOCK_ABI_LAST:
>  		break;
>  	default:
> @@ -366,18 +399,42 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  	access_fs_ro &= ruleset_attr.handled_access_fs;
>  	access_fs_rw &= ruleset_attr.handled_access_fs;
>  
> -	/* Removes bind access attribute if not supported by a user. */
> +	/* Removes TCP bind access attribute if not supported by a user. */

You can send a separate patch with these comment fixes.

>  	env_port_name = getenv(ENV_TCP_BIND_NAME);
>  	if (!env_port_name) {
>  		ruleset_attr.handled_access_net &=
>  			~LANDLOCK_ACCESS_NET_BIND_TCP;
>  	}
> -	/* Removes connect access attribute if not supported by a user. */
> +	/* Removes TCP connect access attribute if not supported by a user. */
>  	env_port_name = getenv(ENV_TCP_CONNECT_NAME);
>  	if (!env_port_name) {
>  		ruleset_attr.handled_access_net &=
>  			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
>  	}
> +	/* Removes UDP bind access attribute if not supported by a user. */
> +	env_port_name = getenv(ENV_UDP_BIND_NAME);
> +	if (!env_port_name) {
> +		ruleset_attr.handled_access_net &=
> +			~LANDLOCK_ACCESS_NET_BIND_UDP;
> +	}
> +	/* Removes UDP bind access attribute if not supported by a user. */
> +	env_port_name = getenv(ENV_UDP_CONNECT_NAME);
> +	if (!env_port_name) {
> +		ruleset_attr.handled_access_net &=
> +			~LANDLOCK_ACCESS_NET_CONNECT_UDP;
> +	}
> +	/* Removes UDP recv access attribute if not supported by a user. */
> +	env_port_name = getenv(ENV_UDP_RECVMSG_NAME);
> +	if (!env_port_name) {
> +		ruleset_attr.handled_access_net &=
> +			~LANDLOCK_ACCESS_NET_RECVMSG_UDP;
> +	}
> +	/* Removes UDP send access attribute if not supported by a user. */
> +	env_port_name = getenv(ENV_UDP_SENDMSG_NAME);
> +	if (!env_port_name) {
> +		ruleset_attr.handled_access_net &=
> +			~LANDLOCK_ACCESS_NET_SENDMSG_UDP;
> +	}
>  
>  	ruleset_fd =
>  		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> @@ -392,7 +449,6 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  	if (populate_ruleset_fs(ENV_FS_RW_NAME, ruleset_fd, access_fs_rw)) {
>  		goto err_close_ruleset;
>  	}
> -
>  	if (populate_ruleset_net(ENV_TCP_BIND_NAME, ruleset_fd,
>  				 LANDLOCK_ACCESS_NET_BIND_TCP)) {
>  		goto err_close_ruleset;
> @@ -401,6 +457,22 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  				 LANDLOCK_ACCESS_NET_CONNECT_TCP)) {
>  		goto err_close_ruleset;
>  	}
> +	if (populate_ruleset_net(ENV_UDP_BIND_NAME, ruleset_fd,
> +				 LANDLOCK_ACCESS_NET_BIND_UDP)) {
> +		goto err_close_ruleset;
> +	}
> +	if (populate_ruleset_net(ENV_UDP_CONNECT_NAME, ruleset_fd,
> +				 LANDLOCK_ACCESS_NET_CONNECT_UDP)) {
> +		goto err_close_ruleset;
> +	}
> +	if (populate_ruleset_net(ENV_UDP_RECVMSG_NAME, ruleset_fd,
> +				 LANDLOCK_ACCESS_NET_RECVMSG_UDP)) {
> +		goto err_close_ruleset;
> +	}
> +	if (populate_ruleset_net(ENV_UDP_SENDMSG_NAME, ruleset_fd,
> +				 LANDLOCK_ACCESS_NET_SENDMSG_UDP)) {
> +		goto err_close_ruleset;
> +	}
>  
>  	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
>  		perror("Failed to restrict privileges");
> -- 
> 2.39.5
> 
> 

